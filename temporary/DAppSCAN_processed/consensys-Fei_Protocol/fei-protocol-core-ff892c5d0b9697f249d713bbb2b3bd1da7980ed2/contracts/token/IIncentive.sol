// File: ../sc_datasets/DAppSCAN/consensys-Fei_Protocol/fei-protocol-core-ff892c5d0b9697f249d713bbb2b3bd1da7980ed2/contracts/token/IIncentive.sol

pragma solidity ^0.6.2;

/// @title incentive contract interface
/// @author Fei Protocol
/// @notice Called by FEI token contract when transferring with an incentivized address
/// @dev should be appointed as a Minter or Burner as needed
interface IIncentive {

	// ----------- Fei only state changing api -----------

	/// @notice apply incentives on transfer
	/// @param sender the sender address of the FEI
	/// @param receiver the receiver address of the FEI
	/// @param operator the operator (msg.sender) of the transfer
	/// @param amount the amount of FEI transferred
    function incentivize(
    	address sender, 
    	address receiver, 
    	address operator, 
    	uint amount
    ) external;
}
