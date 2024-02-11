// File: ../sc_datasets/DAppSCAN/Coinfabrik-EMDX – Protocol Audit/perpetual-protocol-emdx-main/src/bridge/external/IMultiTokenMediator.sol

// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.6.9;

interface IMultiTokenMediator {
    function relayTokens(
        address token,
        address _receiver,
        uint256 _value
    ) external;
}
