// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-WstETH/lido-dao-ea6fa222004b88e6a24b566a51e5b56b0079272d/contracts/0.4.24/test_helpers/LidoMockForOracle.sol

// SPDX-FileCopyrightText: 2020 Lido <info@lido.fi>

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.24;


/**
  * @dev Only for testing purposes! Lido version with some functions exposed.
  */
contract LidoMockForOracle {
    uint256 private totalPooledEther;

    function totalSupply() external view returns (uint256) {
        return totalPooledEther;
    }

    function pushBeacon(uint256 /*_beaconValidators*/, uint256 _beaconBalance) external {
        totalPooledEther = _beaconBalance;
    }

    function getTotalShares() public view returns (uint256) {
        return 42;
    }

    function pretendTotalPooledEtherGweiForTest(uint256 _val) public {
        totalPooledEther = _val * 1e9; // gwei to wei
    }
}
