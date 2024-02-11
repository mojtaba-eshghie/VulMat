// File: ../sc_datasets/DAppSCAN/Coinbae-SpaceMonkey/SpaceMonkey0x9298f766581650e81357f5C66C91cc003f2b75Aa/root/workspace/GXC/contracts/ERC/IERC223Recipient.sol

pragma solidity ^0.8.0;
// SPDX-License-Identifier: UNLICENSED

 /**
 * @title Contract that will work with ERC223 tokens.
 */
 
interface IERC223Recipient { 
/**
 * @dev Standard ERC223 function that will handle incoming token transfers.
 *
 * @param _from  Token sender address.
 * @param _value Amount of tokens.
 * @param _data  Transaction metadata.
 */
    function tokenFallback(address _from, uint _value, bytes calldata _data) external;
}
