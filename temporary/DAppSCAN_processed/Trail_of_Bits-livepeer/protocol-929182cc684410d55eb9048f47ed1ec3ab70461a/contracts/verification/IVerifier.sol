// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-livepeer/protocol-929182cc684410d55eb9048f47ed1ec3ab70461a/contracts/verification/IVerifier.sol

pragma solidity ^0.4.18;


/**
 * @title Interface for a Verifier. Can be backed by any implementaiton including oracles or Truebit
 */
contract IVerifier {
    function verify(
        uint256 _jobId,
        uint256 _claimId,
        uint256 _segmentNumber,
        string _transcodingOptions,
        string _dataStorageHash,
        bytes32[2] _dataHashes
    )
        external
        payable;

    function getPrice() public view returns (uint256);
}
