// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-SeaportProtocol/seaport-f17082fca3e99b409f53040d8858e84b0246aa22/contracts/interfaces/AbridgedTokenInterfaces.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

interface ERC20Interface {
    function transferFrom(
        address,
        address,
        uint256
    ) external returns (bool);
}

interface ERC721Interface {
    function transferFrom(
        address,
        address,
        uint256
    ) external;
}

interface ERC1155Interface {
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}
