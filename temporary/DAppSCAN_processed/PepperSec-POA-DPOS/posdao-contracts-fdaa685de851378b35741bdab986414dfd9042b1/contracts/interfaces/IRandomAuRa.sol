// File: ../sc_datasets/DAppSCAN/PepperSec-POA-DPOS/posdao-contracts-fdaa685de851378b35741bdab986414dfd9042b1/contracts/interfaces/IRandomAuRa.sol

pragma solidity 0.5.9;


interface IRandomAuRa {
    function initialize(uint256, address) external;
    function onFinishCollectRound() external;
    function commitHashCallable(address, bytes32) external view returns(bool);
    function revealSecretCallable(address, uint256) external view returns(bool);
}
