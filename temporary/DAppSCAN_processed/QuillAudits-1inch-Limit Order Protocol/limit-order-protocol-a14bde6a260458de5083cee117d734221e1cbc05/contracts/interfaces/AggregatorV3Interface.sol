// File: ../sc_datasets/DAppSCAN/QuillAudits-1inch-Limit Order Protocol/limit-order-protocol-a14bde6a260458de5083cee117d734221e1cbc05/contracts/interfaces/AggregatorV3Interface.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

interface AggregatorV3Interface {
    function latestAnswer() external view returns (int256);
    function latestTimestamp() external view returns (uint256);
}
