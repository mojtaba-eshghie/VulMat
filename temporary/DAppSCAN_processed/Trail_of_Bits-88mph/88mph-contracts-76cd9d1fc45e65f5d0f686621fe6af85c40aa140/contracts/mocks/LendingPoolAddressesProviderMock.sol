// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-88mph/88mph-contracts-76cd9d1fc45e65f5d0f686621fe6af85c40aa140/contracts/mocks/LendingPoolAddressesProviderMock.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.3;

contract LendingPoolAddressesProviderMock {
    address internal pool;
    address internal core;

    function getLendingPool() external view returns (address) {
        return pool;
    }

    function setLendingPoolImpl(address _pool) external {
        pool = _pool;
    }
}
