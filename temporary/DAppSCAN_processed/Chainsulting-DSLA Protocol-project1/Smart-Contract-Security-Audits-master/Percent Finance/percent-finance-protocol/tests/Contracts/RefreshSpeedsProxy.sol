// File: ../sc_datasets/DAppSCAN/Chainsulting-DSLA Protocol-project1/Smart-Contract-Security-Audits-master/Percent Finance/percent-finance-protocol/tests/Contracts/RefreshSpeedsProxy.sol

pragma solidity ^0.5.16;

interface IComptroller {
	function refreshCompSpeeds() external;
}

contract RefreshSpeedsProxy {
	constructor(address comptroller) public {
		IComptroller(comptroller).refreshCompSpeeds();
	}
}
