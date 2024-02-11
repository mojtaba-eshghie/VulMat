// File: ../sc_datasets/DAppSCAN/Coinfabrik-Avalaunch Audit Allocation Staking and Cooldown feature/xava-protocol-master/contracts/interfaces/IAllocationStaking.sol

//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.6.12;

interface IAllocationStaking {
    function redistributeXava(uint256 _pid, address _user, uint256 _amountToBurn) external;
    function deposited(uint256 _pid, address _user) external view returns (uint256);
    function setTokensUnlockTime(uint256 _pid, address _user, uint256 _tokensUnlockTime) external;
}
