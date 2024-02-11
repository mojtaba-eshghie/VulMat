// File: ../sc_datasets/DAppSCAN/HAECHI_AUDIT-Pickle_Finance/protocol-9b0f330a16bc35c964211feae3b335ab398c01b6/src/interfaces/proxy.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.7;

interface Proxy {
    function execute(
        address to,
        uint256 value,
        bytes calldata data
    ) external returns (bool, bytes memory);

    function increaseAmount(uint256) external;
}
