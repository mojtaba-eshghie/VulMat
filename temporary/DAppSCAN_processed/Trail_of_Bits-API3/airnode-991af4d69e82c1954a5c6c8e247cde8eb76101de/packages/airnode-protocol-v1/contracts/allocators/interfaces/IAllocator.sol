// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/allocators/interfaces/IAllocator.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAllocator {
    event SetSlot(
        address indexed airnode,
        uint256 slotIndex,
        bytes32 subscriptionId,
        uint64 expirationTimestamp
    );

    event ResetSlot(address indexed airnode, uint256 slotIndex);

    function setSlot(
        address airnode,
        uint256 slotIndex,
        bytes32 subscriptionId,
        uint64 expirationTimestamp
    ) external;

    function resetSlot(address airnode, uint256 slotIndex) external;

    function setterOfSlotIsCanStillSet(address airnode, uint256 slotIndex)
        external
        view
        returns (bool);

    // solhint-disable-next-line func-name-mixedcase
    function SLOT_SETTER_ROLE_DESCRIPTION()
        external
        view
        returns (string memory);

    function airnodeToSlotIndexToSlot(address airnode, uint256 slotIndex)
        external
        view
        returns (
            bytes32 subscriptionId,
            address setter,
            uint64 expirationTimestamp
        );
}
