pragma solidity ^0.4.18;
//  defining the event both in the contract and the library will 
//  trick clients into thinking that it was actually the main
//   contract who sent the event and not the library.
library EventEmitterLib {
    function emit(string s) {
        Emit(s);
    }
    
    event Emit(string s);
}

contract EventEmitterContract {
    using EventEmitterLib for string;
    
    function emit(string s) {
        s.emit();
    }
    
    event Emit(string s);
}