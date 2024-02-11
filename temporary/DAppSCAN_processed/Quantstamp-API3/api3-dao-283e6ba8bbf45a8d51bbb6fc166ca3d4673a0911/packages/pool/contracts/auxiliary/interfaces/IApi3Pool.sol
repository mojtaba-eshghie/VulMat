// File: ../sc_datasets/DAppSCAN/Quantstamp-API3/api3-dao-283e6ba8bbf45a8d51bbb6fc166ca3d4673a0911/packages/pool/contracts/auxiliary/interfaces/IApi3Pool.sol

//SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface IApi3Pool {
    function deposit(
        address source,
        uint256 amount,
        address userAddress
        )
        external;

    function depositWithVesting(
        address source,
        uint256 amount,
        address userAddress,
        uint256 releaseStart,
        uint256 releaseEnd
        )
        external;
}
