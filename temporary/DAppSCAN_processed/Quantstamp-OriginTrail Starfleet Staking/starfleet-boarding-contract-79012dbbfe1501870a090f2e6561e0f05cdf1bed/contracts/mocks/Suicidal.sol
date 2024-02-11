// File: ../sc_datasets/DAppSCAN/Quantstamp-OriginTrail Starfleet Staking/starfleet-boarding-contract-79012dbbfe1501870a090f2e6561e0f05cdf1bed/contracts/mocks/Suicidal.sol

pragma solidity 0.6.10;
contract Suicidal {

	event EthReceived(uint256 value); 
	fallback () external payable {
		emit EthReceived(msg.value);
	}  
	function dieAndSendETH(address payable receiver) public { 
		selfdestruct(receiver); 
	}
}
