// File: ../sc_datasets/DAppSCAN/PeckShield-XSwap/xswap-326a3246b327cd2b8481fd8c22fe8d864e43b0da/contracts/interface/IChai.sol

pragma solidity ^0.5.4;

interface IChai {
	function join(address dst, uint wad) external;
	function exit(address dst, uint wad) external;
	function draw(address src, uint wad) external;
}
