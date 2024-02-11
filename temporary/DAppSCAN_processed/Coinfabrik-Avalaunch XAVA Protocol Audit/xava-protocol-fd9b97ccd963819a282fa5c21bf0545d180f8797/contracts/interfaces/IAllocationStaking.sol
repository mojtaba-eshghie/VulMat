// File: ../sc_datasets/DAppSCAN/Coinfabrik-Avalaunch XAVA Protocol Audit/xava-protocol-fd9b97ccd963819a282fa5c21bf0545d180f8797/contracts/interfaces/IAllocationStaking.sol

//"SPDX-License-Identifier: UNLICENSED"
pragma solidity 0.6.12;

interface IAllocationStaking {
    function redistributeXava(uint256 _pid, address _user, uint256 _amountToBurn) external;
    function deposited(uint256 _pid, address _user) external view returns (uint256);
    function setTokensUnlockTime(uint256 _pid, address _user, uint256 _tokensUnlockTime) external;
}
