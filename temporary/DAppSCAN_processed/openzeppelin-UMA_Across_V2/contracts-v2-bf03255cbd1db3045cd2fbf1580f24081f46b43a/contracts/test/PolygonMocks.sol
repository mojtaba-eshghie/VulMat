// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA_Across_V2/contracts-v2-bf03255cbd1db3045cd2fbf1580f24081f46b43a/contracts/test/PolygonMocks.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

contract RootChainManagerMock {
    function depositEtherFor(address user) external payable {}

    function depositFor(
        address user,
        address rootToken,
        bytes calldata depositData
    ) external {}
}

contract FxStateSenderMock {
    function sendMessageToChild(address _receiver, bytes calldata _data) external {}
}
