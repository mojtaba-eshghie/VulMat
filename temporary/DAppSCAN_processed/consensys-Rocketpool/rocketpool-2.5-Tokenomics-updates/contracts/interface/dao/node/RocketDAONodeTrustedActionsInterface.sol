// File: ../sc_datasets/DAppSCAN/consensys-Rocketpool/rocketpool-2.5-Tokenomics-updates/contracts/interface/dao/node/RocketDAONodeTrustedActionsInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketDAONodeTrustedActionsInterface {
    function actionJoin() external;
    function actionJoinRequired(address _nodeAddress) external;
    function actionLeave(address _rplBondRefundAddress) external;
    function actionReplace() external; 
    function actionKick(address _nodeAddress) external;
    function actionChallengeMake(address _nodeAddress) external payable;
    function actionChallengeDecide(address _nodeAddress) external;
}
