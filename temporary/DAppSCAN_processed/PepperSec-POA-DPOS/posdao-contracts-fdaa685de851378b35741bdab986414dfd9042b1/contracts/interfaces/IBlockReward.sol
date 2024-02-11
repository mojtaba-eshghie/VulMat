// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IBlockReward.sol

pragma solidity 0.5.9;


interface IBlockReward {
    function initialize(address) external;
    function DELEGATORS_ALIQUOT() external view returns(uint256); // solhint-disable-line func-name-mixedcase
    function isRewarding() external view returns(bool);
    function isSnapshotting() external view returns(bool);
    function mintedTotally() external view returns(uint256);
    function mintedTotallyByBridge(address _bridge) external view returns(uint256);
}
