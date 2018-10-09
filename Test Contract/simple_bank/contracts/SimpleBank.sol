pragma solidity ^0.4.13;
contract SimpleBank {

    /* Fill in the keyword. Hint: We want to protect our users balance from modification*/
    mapping (address => uint) private balances;
    // One account can enroll only once.  
    mapping (address => bool) private account;

    /* Let's make sure everyone knows who owns the bank. Use the appropriate keyword for this*/
    address public owner;
    uint constant rate = 0.01 ether;
  
    // Events - publicize actions to external listeners
    /* Add 2 arguments for this event, an accountAddress and an amount */
    event LogDepositMade(address accountAddress, uint amount);
    
    modifier returnAmount(uint amount) {
    //refund them after pay for item (why it is before, _ checks for logic fo func)
    _;
    uint total_value = msg.value - amount*rate;
    if(total_value >0){
        msg.sender.transfer(total_value);
    }
  }

    // Constructor, can receive one or many variables here; only one allowed
    constructor() public payable{
        /* Set the owner to the creator of this contract */
        owner = msg.sender;
    }

    /// @notice Enroll a customer with the bank, giving them 1000 tokens for free
    /// @return The balance of the user after enrolling
    function enroll() public returns (uint){
      /* Set the sender's balance to 1000, return the sender's balance */
      require(!account[msg.sender]);
      balances[msg.sender] = 1000;
      account[msg.sender] = true;
      return balances[msg.sender];
    }

    /// @notice Deposit ether into bank
    /// @return The balance of the user after the deposit is made
    function deposit(uint amount) returnAmount(amount) payable public {
        /* Add the amount to the user's balance, call the event associated with a deposit,
          then return the balance of the user */
          require(msg.value >= amount*rate);
          balances[msg.sender] += amount;
          emit LogDepositMade(msg.sender, amount);
    }

    /// @notice Withdraw ether from bank
    /// @dev This does not return any excess ether sent to it
    /// @param withdrawAmount amount you want to withdraw
    /// @return The balance remaining for the user
    function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
        /* If the sender's balance is at least the amount they want to withdraw,
           Subtract the amount from the sender's balance, and try to send that amount of ether
           to the user attempting to withdraw. IF the send fails, add the amount back to the user's balance
           return the user's balance.*/
           if (balances[msg.sender] >= withdrawAmount) {
            balances[msg.sender] -= withdrawAmount;
             if (!msg.sender.send(withdrawAmount*rate)) {
                balances[msg.sender] += withdrawAmount;
            }
           }

           return balances[msg.sender];
    }

    /// @notice Get balance
    /// @return The balance of the user
    // A SPECIAL KEYWORD prevents function from editing state variables;
    // allows function to run locally/off blockchain
    function balance() view public returns (uint) {
        /* Get the balance of the sender of this transaction */
        return balances[msg.sender];
    }

    // Fallback function - Called if other functions don't match call or
    // sent ether without data
    // Typically, called when invalid data is sent
    // Added so ether sent to this contract is reverted if the contract fails
    // otherwise, the sender's money is transferred to contract
    function () payable public {
        revert();
    }
}
