// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project1/openzeppelin-contracts-2.0.1/contracts/math/Math.sol

pragma solidity ^0.4.24;

/**
 * @title Math
 * @dev Assorted math operations
 */
library Math {
  /**
  * @dev Returns the largest of two numbers.
  */
  function max(uint256 a, uint256 b) internal pure returns (uint256) {
    return a >= b ? a : b;
  }

  /**
  * @dev Returns the smallest of two numbers.
  */
  function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return a < b ? a : b;
  }

  /**
  * @dev Calculates the average of two numbers. Since these are integers,
  * averages of an even and odd number cannot be represented, and will be
  * rounded down.
  */
  function average(uint256 a, uint256 b) internal pure returns (uint256) {
    // (a + b) / 2 can overflow, so we distribute
    return (a / 2) + (b / 2) + ((a % 2 + b % 2) / 2);
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project1/openzeppelin-contracts-2.0.1/contracts/mocks/MathMock.sol

pragma solidity ^0.4.24;

contract MathMock {
  function max(uint256 a, uint256 b) public pure returns (uint256) {
    return Math.max(a, b);
  }

  function min(uint256 a, uint256 b) public pure returns (uint256) {
    return Math.min(a, b);
  }

  function average(uint256 a, uint256 b) public pure returns (uint256) {
    return Math.average(a, b);
  }
}
