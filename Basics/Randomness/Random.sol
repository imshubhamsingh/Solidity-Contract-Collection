pragma solidity 0.4.18;

contract Random {
    function unsafeBlockRandom() 
     public
     view
     returns (uint) {
         return uint(block.blockhash(block.number)) % 100;
     }

    uint private _baseIncrement;
    function unsafeIncrementRandom()
     public
     returns (uint) {
         return uint(sha3(_baseIncrement++)) % 100;
    }

}