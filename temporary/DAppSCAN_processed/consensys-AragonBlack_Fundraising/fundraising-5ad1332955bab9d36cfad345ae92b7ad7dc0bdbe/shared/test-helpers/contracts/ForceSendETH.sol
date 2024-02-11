// File: ../sc_datasets/DAppSCAN/consensys-AragonBlack_Fundraising/fundraising-5ad1332955bab9d36cfad345ae92b7ad7dc0bdbe/shared/test-helpers/contracts/ForceSendETH.sol

pragma solidity 0.4.24;


contract ForceSendETH {
  // Truffle doesn't support selfdestructing on constructor:
  // Error: The contract code couldn't be stored, please check your gas amount.

  function sendByDying(address recipient) external payable {
    selfdestruct(recipient);
  }
}
