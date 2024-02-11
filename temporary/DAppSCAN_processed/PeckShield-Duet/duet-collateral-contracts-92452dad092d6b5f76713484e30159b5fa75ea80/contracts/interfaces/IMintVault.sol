// File: ../sc_datasets/DAppSCAN/PeckShield-Duet/duet-collateral-contracts-92452dad092d6b5f76713484e30159b5fa75ea80/contracts/interfaces/IMintVault.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface IMintVault {

  function borrows(address user) external view returns(uint amount);
  function borrow(uint256 amount) external;
  function repay(uint256 amount) external;
  function repayTo(address to, uint256 amount) external;

  function valueToAmount(uint value, bool dp) external view returns(uint amount);

}
