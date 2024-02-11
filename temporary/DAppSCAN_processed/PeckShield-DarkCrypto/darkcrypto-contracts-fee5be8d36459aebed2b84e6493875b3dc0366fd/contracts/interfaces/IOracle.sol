// File: ../sc_datasets/DAppSCAN/PeckShield-DarkCrypto/darkcrypto-contracts-fee5be8d36459aebed2b84e6493875b3dc0366fd/contracts/interfaces/IOracle.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface IOracle {
    function update() external;

    function consult(address _token, uint256 _amountIn) external view returns (uint144 amountOut);

    function twap(address _token, uint256 _amountIn) external view returns (uint144 _amountOut);
}
