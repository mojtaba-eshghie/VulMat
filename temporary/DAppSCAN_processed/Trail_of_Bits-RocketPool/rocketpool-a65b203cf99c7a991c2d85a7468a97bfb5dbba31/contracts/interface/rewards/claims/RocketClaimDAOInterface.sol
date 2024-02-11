// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-RocketPool/rocketpool-a65b203cf99c7a991c2d85a7468a97bfb5dbba31/contracts/interface/rewards/claims/RocketClaimDAOInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketClaimDAOInterface {
    function getEnabled() external view returns (bool);
    function spend(string memory _invoiceID, address _recipientAddress, uint256 _amount) external;
}
