pragma solidity ^0.4.8;

contract DataType {
    bool mybool = true;
    int8 myInt;
    uint8 myUint;
    
    // string is just an array
    string myString;
    uint8[] myIntArray;
    
    
    // function fun(string[] foo){
    //     Nested array not yet implemented
    // }
    
    byte myByte;
    bytes8 b8;
    bytes15 b15;
    
    // default 128 bit 19 decimal place
    // fixed256x1 myFixed = 22.1; Not implemented 
    // ufixed256x1 ufixed;
    
    enum Action {ADD,SUBTRACT,UPDATE}
    
    Action myAction = Action.ADD;
    
    address myaddress; 
    
    function assignAddress() public{
        myaddress = msg.sender;
        myaddress.balance;
        myaddress.transfer(20);
    }
    
    uint[] myArray = [1,2,3];
    
    function arrPush(){
        myArray.push(2);
        myArray.length;
        myArray[0];
    }
    
    struct Account {
        uint balance;
        uint dailyLimit;
    }
    
    Account account1;
    
    function accountFun(){
        account1.balance = 100;
    }
    
    mapping (address => Account) _accounts;
    
    function () payable {
        _accounts[msg.sender].balance += msg.value;
    }
    
    function getBalance() constant returns (uint){
        return _accounts[msg.sender].balance;
    }
}
