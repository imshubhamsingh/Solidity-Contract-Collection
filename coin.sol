pragma solidity ^0.4.8;
import "./Tokens/Token.sol";
import "./Tokens/ERC20"

contract Coin is Token("MFT", "My First Token", 18, 1000) ERC20{
    /*
    * @title A simple subcurrency based on ethereum
    * @author Shubham Singh
    */
    address owner;
    bytes32 name;
}
