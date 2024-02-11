// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-livepeer/protocol-929182cc684410d55eb9048f47ed1ec3ab70461a/contracts/rounds/IRoundsManager.sol

pragma solidity ^0.4.18;


/**
 * @title RoundsManager interface
 */
contract IRoundsManager {
    // Events
    event NewRound(uint256 round);

    // External functions
    function initializeRound() external;

    // Public functions
    function blockNum() public view returns (uint256);
    function blockHash(uint256 _block) public view returns (bytes32);
    function currentRound() public view returns (uint256);
    function currentRoundStartBlock() public view returns (uint256);
    function currentRoundInitialized() public view returns (bool);
    function currentRoundLocked() public view returns (bool);
}
