pragma solidity ^0.4.16;

interface ERC20 {

    // Amount of token we have in circulation
    function totalSupply() constant returns (uint _totalSupply);

    //how many tokens a specific address has
    function balanceOf(address _owner) constant returns (uint balance);

    // Allow user to transfer own token to someone else
    function transfer( address _to, uint value) returns (bool success);

    //
}