// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-livepeer/protocol-929182cc684410d55eb9048f47ed1ec3ab70461a/contracts/verification/IVerifiable.sol

pragma solidity ^0.4.18;


/*
 * @title Interface for contract that receives verification results
 * TODO: switch to interface type
 */
contract IVerifiable {
    // External functions
    function receiveVerification(uint256 _jobId, uint256 _claimId, uint256 _segmentNumber, bool _result) external;
}
