// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IValidatorSetHBBFT.sol

pragma solidity 0.5.9;
pragma experimental ABIEncoderV2;


interface IValidatorSetHBBFT {
    function clearMaliceReported(address) external;
    function initializePublicKeys(bytes[] calldata) external;
    function savePublicKey(address, bytes calldata) external;
}
