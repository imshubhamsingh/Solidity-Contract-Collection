pragma solidity ^0.4.16;

interface ERC223 {

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