// File: ../sc_datasets/DAppSCAN/PeckShield-Tranchessv1.0/contract-core-5ac3d997da3ef37b0135565a11c5ebcc519862aa/contracts/interfaces/IAprOracle.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

interface IAprOracle {
    function capture() external returns (uint256 dailyRate);
}
