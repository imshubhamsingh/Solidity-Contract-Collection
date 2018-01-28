pragma solidity ^0.4.18;

import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract ConiFlip is usingOracalize {
    // result from wolframAplha using oracalize
    string public result;
    bytes32 public oraclizeID;

    function CoinFlip() payable {
        oracalizeID = oraclize_query('WolframAlpha', 'flip a coin');
    }

    function __callback(bytes32 _oraclizeID, string _result){
        require(msg.sender == oraclize_cbAddress());
        result = _result;
    }

}