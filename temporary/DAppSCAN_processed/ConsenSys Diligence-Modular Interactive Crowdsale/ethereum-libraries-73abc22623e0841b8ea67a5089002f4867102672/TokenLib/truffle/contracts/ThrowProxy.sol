// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Modular Interactive Crowdsale/ethereum-libraries-73abc22623e0841b8ea67a5089002f4867102672/TokenLib/truffle/contracts/ThrowProxy.sol

pragma solidity ^0.4.18;

contract ThrowProxy {
  address public target;
  bytes data;

  function ThrowProxy(address _target) {
    target = _target;
  }

  //prime the data using the fallback function.
  function() {
    data = msg.data;
  }

  function execute() returns (bool) {
    return target.call(data);
  }
}
