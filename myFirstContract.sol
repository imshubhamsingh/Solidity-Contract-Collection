pragma solidity ^0.4.8;

contract Bank {
    
}

contract MyFirstContract is Bank {
    string private name;
    uint private age;

    function setName(string newName) {
        name = newName;
    }

    function getName() returns (string) {
        return name;                
    }

    function setAge(uint newAge) {
        age = newAge;
    }

    function getAge() returns (uint) {
        return age;                
    }
}