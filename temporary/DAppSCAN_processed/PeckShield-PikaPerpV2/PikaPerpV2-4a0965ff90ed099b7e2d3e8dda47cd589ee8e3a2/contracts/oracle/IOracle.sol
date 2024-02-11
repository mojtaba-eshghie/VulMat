// File: ../sc_datasets/DAppSCAN/PeckShield-PikaPerpV2/PikaPerpV2-4a0965ff90ed099b7e2d3e8dda47cd589ee8e3a2/contracts/oracle/IOracle.sol

pragma solidity ^0.8.0;

interface IOracle {
    function getPrice(address feed) external view returns (uint256);
}
