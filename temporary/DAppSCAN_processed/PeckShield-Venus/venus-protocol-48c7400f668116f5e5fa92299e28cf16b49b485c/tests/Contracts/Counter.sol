// File: ../sc_datasets/DAppSCAN/PeckShield-Venus/venus-protocol-48c7400f668116f5e5fa92299e28cf16b49b485c/tests/Contracts/Counter.sol

pragma solidity ^0.5.16;

contract Counter {
  uint public count;
  uint public count2;

  function increment(uint amount) public payable {
    count += amount;
  }

  function decrement(uint amount) public payable {
    require(amount <= count, "counter underflow");
    count -= amount;
  }

  function increment(uint amount, uint amount2) public payable {
    count += amount;
    count2 += amount2;
  }

  function notZero() public view {
    require(count != 0, "Counter::notZero");
  }

  function doRevert() public pure {
    require(false, "Counter::revert Testing");
  }
}
