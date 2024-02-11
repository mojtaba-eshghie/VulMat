// File: ../sc_datasets/DAppSCAN/SlowMist-Booster-Protocol_智能安全审计报告/boosterProtocol-946b15629c410d706856584f3aa04001d6a55bd2/interfaces/IMdexHecoPool.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 <0.8.0;

interface IMdexHecoPool {

    // function LpOfPid(address _lpaddress) external view returns (uint256);

    // function poolLength() external view returns (uint256);

    // function totalAllocPoint() external view returns (uint256);

    // function reward(uint256 blockNumber) external view returns (uint256);

    function poolInfo(uint256 _pid) external view returns(address, uint256, uint256, uint256, uint256, uint256);

    function userInfo(uint256 _pid, address _user) external view returns (uint256, uint256, uint256);

    function deposit(uint256 _pid, uint256 _amount) external;

    function pending(uint256 _pid, address _user) external view returns (uint256);

    // function updatePool(uint256 _pid) external;

    function withdraw(uint256 _pid, uint256 _amount) external;

    function emergencyWithdraw(uint256 _pid) external;

}
