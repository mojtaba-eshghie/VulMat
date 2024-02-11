// File: ../sc_datasets/DAppSCAN/PeckShield-XSwap/xswap-326a3246b327cd2b8481fd8c22fe8d864e43b0da/contracts/interface/ILendFMe.sol

pragma solidity ^0.5.4;

interface ILendFMe {
	function supply(address _token, uint _amounts) external returns (uint);
	function withdraw(address _token, uint _amounts) external returns (uint);
	function getSupplyBalance(address _user, address _token) external view returns (uint256);
}
