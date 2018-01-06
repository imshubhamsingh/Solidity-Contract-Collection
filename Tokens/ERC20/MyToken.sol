pragma solidity ^0.4.16;

import "./ERC20.sol";

contract MyFirstToken is ERC20 {
    string public constant symbol = "MFT";
    string public constant name = "My first Token";
    uint8 public constant decimal = 18;

    uint private constant __totalSupply = 1000;

    mapping (address => uint) private __balanceOf;
    mapping (address => mapping(address => uint)) private __allowances

    function MyFirstToken(){
        _balanceOf[msg.sender] = __totalSupply;
    }

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
             Transfer(msg.sender, _to, _value);
             return true;
         }
         return false;
     }

    function transferFrom(address _from, address _to, uint _value) returns (bool success){
        if(__allowances[_from][msg.sender]> 0 &&
           _value>0 && __balanceOf[_from]>= _value
           __allowances[_from][msg.sender] >= _value 
        ){
             __balanceOf[_from] -= _value;
             __balanceOf[_to] += value;
             __allowances[msg.sender][_from] -= value
             Transfer(_from, _to, _value);
             return true;
        }
        return false;
    }

    function approve(address _spender, uint value) returns (bool success){
        __allowances[msg.sender][_spender] = value
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) constant returns (uint remaining){
         return __allowances[_owner][_spender];
    }

}