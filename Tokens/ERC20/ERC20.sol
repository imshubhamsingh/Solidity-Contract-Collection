pragma solidity ^0.4.16;

interface ERC20 {

    // Amount of token we have in circulation
    function totalSupply() constant returns (uint _totalSupply);

    //how many tokens a specific address has
    function balanceOf(address _owner) constant returns (uint balance);

    // Allow user to transfer own token to someone else
    function transfer(address _to, uint value) returns (bool success);

    // To transfer token from one address to another with some constraint
    function transferFrom(address _from, address _to, uint _value) returns (bool success);

    //Proof fn. To allow management of sepecific tokens by other user
    // and to manipulate tokens on your behalf
    function approve(address _spender, uint value) returns (bool success);

    // How much token can be manipulated by another ethereum address
    function allowance(address _owner, address _spender) constant returns (uint remaining);

    // event for additional logging into ledger
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);

}