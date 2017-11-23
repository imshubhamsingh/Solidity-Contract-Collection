pragma solidity ^0.4.8;

contract TestThrow {
    function testAssert() {
        // More of validating input on runtime.
        // Gas is always consumed on messeged as well
        assert(1==2);        
    }

    function testRequire() {
        // More of requirement
        // Gas is always consumed on messeged as well
        require(1 == 2);
    }

    function testRevert() {
        // revert the gas cost
        revert();        
    }

    function testThrow() {
        throw;
    }
}
