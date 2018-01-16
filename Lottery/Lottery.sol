pragma solidity ^0.4.19;

contract Lottery {
    address manager;
    address[] players;
    
    function Lottery() public {
        manager = msg.sender;
    }

    modifier restricted(){
        require(manager == msg.sender);
        _;
    }
    

    function enterToLottery() public payable {
        require(msg.value >= 0.1 ether);
        players.push(msg.sender);
    }

    function random () private view returns (uint) {
        return uint(keccak256(players, now, block.difficulty)); 
    }

    function pickAWinner() public restricted {
        require(this.balance >= 10 ether);
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        players = new address[](0);
    }

}