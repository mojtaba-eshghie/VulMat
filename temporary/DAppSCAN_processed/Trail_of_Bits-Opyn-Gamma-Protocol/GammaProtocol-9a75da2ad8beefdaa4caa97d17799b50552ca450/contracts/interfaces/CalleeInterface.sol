// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Opyn-Gamma-Protocol/GammaProtocol-9a75da2ad8beefdaa4caa97d17799b50552ca450/contracts/interfaces/CalleeInterface.sol

/**
 * SPDX-License-Identifier: UNLICENSED
 */
pragma solidity 0.6.10;

/**
 * @dev Contract interface that can be called from Controller as a call action.
 */
interface CalleeInterface {
    /**
     * Allows users to send this contract arbitrary data.
     * @param _sender The msg.sender to Controller
     * @param _data Arbitrary data given by the sender
     */
    function callFunction(address payable _sender, bytes memory _data) external;
}
