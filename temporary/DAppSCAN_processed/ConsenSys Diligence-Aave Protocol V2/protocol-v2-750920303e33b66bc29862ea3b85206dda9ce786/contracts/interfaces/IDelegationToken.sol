// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Aave Protocol V2/protocol-v2-750920303e33b66bc29862ea3b85206dda9ce786/contracts/interfaces/IDelegationToken.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/**
 * @title IDelegationToken
 * @dev Implements an interface for tokens with delegation COMP/UNI compatible
 * @author Aave
 **/
interface IDelegationToken {
  function delegate(address delegatee) external;
}
