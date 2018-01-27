pragma solidity ^0.4.18;

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";

contract Casion {

    using SafeMath for uint;

    uint start;
    uint private buyPeriod = 1000;
    uint private verifyPeriod = 100;
    uint private checkPeriod = 100;

    address private winner;    
    uint private winnerSeed;
    bool private hasWinner = false;

    mapping(address => uint) private _tickets;
    mapping(address => uint) private _winnings;

    address[] _entries;
    address[] _verified;

    function Casion()
      public 
    {
      start = block.timestamp;  
    }

    function unsafeEntry(uint number, uint salt) 
      public
      payable
      returns (bool)
    {
      return buyTicket(generateHash(number, salt));
    }

    function generateHash(uint number, uint salt) 
      public
      pure
      returns (uint)
    {
      return uint (keccak256(number+salt));
    }

    function buyTicket(uint hash) 
      public 
      payable
      returns (bool)
    {   
        require(block.timestamp < start + buyPeriod);
        require(1 ether == msg.sender);
        require(_tickets[msg.sender] == 0);
        _tickets[msg.sender] = hash;
        _entries.push(msg.sender);
        return true;
    }    

    function verifyTicket(uint number, uint salt)
      public 
      returns (bool)
    {
      require(block.timestamp >= start + buyPeriod);
      require(block.timestamp <= start + buyPeriod + verifyPeriod);
      require(_tickets[msg.sender] >= 0);
      require(salt > number);
      require(generateHash(number, salt) == _tickets[msg.sender]);
        winnerSeed = winnerSeed ^ salt ^ uint(msg.sender);
        _verified.push(msg.sender);
    }

    function checkWinner()
      public
      returns (bool)
    {
       require(block.timestamp >= start + buyPeriod + verifyPeriod);
       require(block.timestamp < start + buyPeriod + verifyPeriod + checkPeriod);
       if (!hasWinner) {
         winner = _verified[winnerSeed % _verified.length];
         _winnings[winner] = _verified.length.div(100).mul(90);
         hasWinner = true;
       }
       return msg.sender == winner;
    }

    function claim()
      public 
    {
      require(_winnings[msg.sender]>0);
      _winnings[msg.sender] = 0;
      msg.sender.transfer(_winnings[msg.sender]);
    
    }
}