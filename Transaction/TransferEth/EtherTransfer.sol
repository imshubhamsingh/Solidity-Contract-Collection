pragma solidity ^0.4.18;

contract EtherTransferTo {
    function() public payable {

    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract EtherTransferFrom {

    EtherTransferTo private _instance;

    function EtherTransferFrom() public {
        // _instance = EtherTransferTo(address(this))
        _instance = new EtherTransferTo();          
    }    

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function getBalanceOfInstance() public returns (uint) {
        // return address(_instance).balance
        return _instance.getBalance();
    }

    function () public payable {
        // msg.sender.send(msg.vale)
        address(_instance).send(msg.value)
    }
}