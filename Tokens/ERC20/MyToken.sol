pragma solidity ^0.4.16;

import "./ERC20.sol";

contract MyFirstToken is ERC20 {
    string public constant symbol = "MFT";
    string public constant name = "My first Token";
    uint8 public constant decimal = 18;
}