// File: ../sc_datasets/DAppSCAN/PeckShield-DIP001/DIP001-audit/contracts/interface/ITargetHandler.sol

pragma solidity ^0.5.2;

interface ITargetHandler {
	function setDispatcher (address _dispatcher) external;
	function deposit(uint256 _amountss) external returns (uint256); // token deposit
	function withdraw(uint256 _amounts) external returns (uint256);
	function withdrawProfit() external returns (uint256);
	function drainFunds() external returns (uint256);
	function getBalance() external view  returns (uint256);
	function getPrinciple() external view  returns (uint256);
	function getProfit() external view  returns (uint256);
	function getTargetAddress() external view  returns (address);
	function getToken() external view  returns (address);
	function getDispatcher() external view  returns (address);
}

// File: ../sc_datasets/DAppSCAN/PeckShield-DIP001/DIP001-audit/contracts/forTest/FakeDispatcher.sol

pragma solidity ^0.5.2;

contract FakeDispatcher {
    address public fundPool;
    address public profitBeneficiary;

   	uint256 public returnCode;
    
    function setFund(address _addr) external {
        fundPool = _addr;
    }
    
    function setProfitB(address _addr) external {
        profitBeneficiary = _addr;
    }

	function getFund() view external returns (address) {
		return fundPool;
	}

	function getProfitBeneficiary() view external returns (address) {
		return profitBeneficiary;
	}
	
	function callWithdraw(address _target, uint _amount) external {
	    returnCode = ITargetHandler(_target).withdraw(_amount);
	}
	
}
