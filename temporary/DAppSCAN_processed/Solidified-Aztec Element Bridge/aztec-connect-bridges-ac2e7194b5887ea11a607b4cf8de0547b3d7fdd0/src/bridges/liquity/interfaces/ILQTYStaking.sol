// File: ../sc_datasets/DAppSCAN/Solidified-Aztec Element Bridge/aztec-connect-bridges-ac2e7194b5887ea11a607b4cf8de0547b3d7fdd0/src/bridges/liquity/interfaces/ILQTYStaking.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <=0.8.10;

interface ILQTYStaking {
    function stakes(address _user) external view returns (uint);

    function stake(uint _LQTYamount) external;

    function unstake(uint _LQTYamount) external;
}
