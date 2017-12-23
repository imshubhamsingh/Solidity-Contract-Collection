pragma solidity ^0.4.0;

contract Transaction {

    address private owner;

    function Transaction() {
        owner = msg.sender;
    }

    modifier isOwner(){
        require(owner == msg.sender);
        _;
    }

    modifier validValue(){
        assert(msg.value >= 1 ether);
        _;
    }

    event SenderLogger(address);
    event ValueLogger(uint);
    
    function() payable isOwner validValue{
        SenderLogger(msg.sender);
        ValueLogger(msg.value); 
    }
}