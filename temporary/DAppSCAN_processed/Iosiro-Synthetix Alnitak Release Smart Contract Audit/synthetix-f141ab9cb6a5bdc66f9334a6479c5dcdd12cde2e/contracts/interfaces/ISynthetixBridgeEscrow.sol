// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-f141ab9cb6a5bdc66f9334a6479c5dcdd12cde2e/contracts/interfaces/ISynthetixBridgeEscrow.sol

pragma solidity >=0.4.24;

interface ISynthetixBridgeEscrow {
    function approveBridge(
        address _token,
        address _bridge,
        uint256 _amount
    ) external;
}
