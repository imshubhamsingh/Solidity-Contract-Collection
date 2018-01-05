pragma solidity ^0.4.16;

import "./ERC20.sol";

contract MyFirstToken is ERC20 {
    string public constant symbol = "MFT";
    string public constant name = "My first Token";
    uint8 public constant decimal = 18;

    uint private constant __totalSupply = 1000;

    mapping (address => uint) private __balanceOf;
    mapping (address => mapping(address => uint)) private __allowance

    function totalSupply() constant returns (uint _totalSupply){
        __totalSupply = __totalSupply;        
     }

     function balanceOf(address _addr) constant returns (uint balance){
         return __balanceOf[addr]
     }

     function transfer(address _to, uint _value) returns (bool success){
         if(__value>0 && _value<=balanceOf(msg.sender)){
             __balanceOf[msg.sender] -= _value;
             __balanceOf[_to] += value;
             return true;
         }
         return false;
     }

    function transferFrom(address _from, address _to, uint _value) returns (bool success){

    }

    function approve(address _spender, uint value) returns (bool success){

    }

    function allowance(address _owner, address _spender) constant returns (uint remaining){

    }

}