// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Opyn-Gamma-Protocol/GammaProtocol-9a75da2ad8beefdaa4caa97d17799b50552ca450/contracts/tests/CallTester.sol

/**
 * SPDX-License-Identifier: UNLICENSED
 */
pragma solidity 0.6.10;

/**
 * @author Opyn Team
 * @notice Call action testing contract
 */
contract CallTester {
    event CallFunction(address sender, bytes data);

    function callFunction(address _sender, bytes memory _data) external {
        emit CallFunction(_sender, _data);
    }
}
