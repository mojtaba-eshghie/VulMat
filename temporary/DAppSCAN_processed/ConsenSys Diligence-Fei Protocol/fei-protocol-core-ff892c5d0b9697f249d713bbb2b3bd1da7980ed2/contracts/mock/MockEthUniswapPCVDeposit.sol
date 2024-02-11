// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/pcv/IPCVDeposit.sol

pragma solidity ^0.6.2;

/// @title a PCV Deposit interface
/// @author Fei Protocol
interface IPCVDeposit {

	// ----------- Events -----------
    event Deposit(address indexed _from, uint _amount);

    event Withdrawal(address indexed _caller, address indexed _to, uint _amount);

    // ----------- State changing api -----------

    /// @notice deposit tokens into the PCV allocation
    /// @param amount of tokens deposited
    function deposit(uint amount) external payable;

    // ----------- PCV Controller only state changing api -----------

    /// @notice withdraw tokens from the PCV allocation
    /// @param amount of tokens withdrawn
    /// @param to the address to send PCV to
    function withdraw(address to, uint amount) external;

    // ----------- Getters -----------
    
    /// @notice returns total value of PCV in the Deposit
    function totalValue() external view returns(uint);
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/mock/MockEthPCVDeposit.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract MockEthPCVDeposit is IPCVDeposit {

	address payable beneficiary;
    uint256 total = 0;

	constructor(address payable _beneficiary) public {
		beneficiary = _beneficiary;
	}

    function deposit(uint256 amount) external override payable {
    	require(amount == msg.value, "MockEthPCVDeposit: Sent value does not equal input");
    	beneficiary.transfer(amount);
        total += amount;
    }

    function withdraw(address to, uint256 amount) external override {
        require(address(this).balance >= amount, "MockEthPCVDeposit: Not enough value held");
        total -= amount;
        payable(to).transfer(amount);
    }

    function totalValue() external view override returns(uint256) {
    	return total;
    }

}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Fei Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/mock/MockEthUniswapPCVDeposit.sol

pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract MockEthUniswapPCVDeposit is MockEthPCVDeposit {

    address public pair;

	constructor(address _pair) 
        MockEthPCVDeposit(payable(this))
    public {
        pair = _pair;
    }

    fallback() external payable {

    }
}
