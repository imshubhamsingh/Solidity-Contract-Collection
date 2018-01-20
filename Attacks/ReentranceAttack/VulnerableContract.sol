pragma solidity ^0.4.18;

contract Vulnerable {

    mapping (address => uint) public balances;

    function sendMoney() public payable {
        put();
    }

    function put() public payable {
        balances[msg.sender] = msg.value;
    }

      function get() public {
        if (!msg.sender.call.value(balances[msg.sender])()) {
            throw;
        }
        balances[msg.sender] = 0;
    }
    
    function() public {
        throw;
    }
}
