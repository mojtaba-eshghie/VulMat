// File: ../sc_datasets/DAppSCAN/PeckShield-Duet/duet-collateral-contracts-92452dad092d6b5f76713484e30159b5fa75ea80/contracts/interfaces/IDUSD.sol

//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

interface IDUSD {
  function mint(address to, uint256 amount) external;
  function burn(uint256 amount) external;
  function burnme(uint256 amount) external;
}
