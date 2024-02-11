// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-RocketPool/rocketpool-a65b203cf99c7a991c2d85a7468a97bfb5dbba31/contracts/interface/dao/node/RocketDAONodeTrustedActionsInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAONodeTrustedActionsInterface {
    function actionJoin() external;
    function actionJoinRequired(address _nodeAddress) external;
    function actionLeave(address _rplBondRefundAddress) external;
    function actionKick(address _nodeAddress, uint256 _rplFine) external;
    function actionChallengeMake(address _nodeAddress) external payable;
    function actionChallengeDecide(address _nodeAddress) external;
}
