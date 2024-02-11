// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Vault V2 (Vyper part)/contracts-461ff006f6da63b339819fdb5e76468656d6625c/lending-optimizer/contracts/interfaces/ILimaOracle.sol

pragma solidity ^0.6.6;

interface ILimaOracle {
    function fetchBestTokenAPR()
        external
        view
        returns (
            uint8,
            address,
            address
        );

    function requestDeliveryStatus(address _receiver)
        external 
        returns  (
            bytes32 requestId
        );
}
