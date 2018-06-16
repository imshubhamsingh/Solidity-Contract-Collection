pragma solidity ^0.4.13;


contract Tokensale {
    uint hardcap = 10000 ether;
    
    function fetchCap() public view returns(uint) {
        return hardcap;
    }

}

contract Presale is Tokensale {
    uint hardcap = 1000 ether;
    
    constructor() Tokensale() public {}
}