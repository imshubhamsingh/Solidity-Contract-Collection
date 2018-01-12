pragma solidity^0.4.12;

contract Test {
    function test(uint[20] a) public returns (uint){
         return a[10]*2;
    }
    // takes less gas External are effective while using with array as they use directly from 
    // from callback rather then copying into memory stack
    function test2(uint[20] a) external returns (uint){
         return a[10]*2;
    }

    // not part of memory of the contact , use this tho access it
    function externalCall() external returns (uint){
        return 23;       
    }

    // public is part of insctance
    function publicCall() public returns (uint) {
        return 23;
    }
}
