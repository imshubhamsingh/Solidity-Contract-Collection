pragma solidity ^0.4.8;

import './library.sol';

contract UseLibraries {
    using IntExtended for uint;

    function testIncrement (uint _base) returns (uint) {
        return IntExtended.increment(_base);
    }

    function testDecrement (uint _base) returns (uint) {
        return IntExtended.decrement(_base);
    }

    function testIncrementByValue (uint _base, uint _value) returns (uint) {
        return _base.incrementByValue(_value);
    }

    function testDecrementByValue (uint _base, uint _value) returns (uint) {
        return _base.decrementByValue(_value);
    }
}