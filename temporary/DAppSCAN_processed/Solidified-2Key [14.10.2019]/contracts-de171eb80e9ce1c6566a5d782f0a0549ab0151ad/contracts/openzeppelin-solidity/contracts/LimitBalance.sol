// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/LimitBalance.sol

pragma solidity ^0.4.24;


/**
 * @title LimitBalance
 * @dev Simple contract to limit the balance of child contract.
 * Note this doesn't prevent other contracts to send funds by using selfdestruct(address);
 * See: https://github.com/ConsenSys/smart-contract-best-practices#remember-that-ether-can-be-forcibly-sent-to-an-account
 */
contract LimitBalance {

  uint256 public limit;

  /**
   * @dev Constructor that sets the passed value as a limit.
   * @param _limit uint256 to represent the limit.
   */
  constructor(uint256 _limit) public {
    limit = _limit;
  }

  /**
   * @dev Checks if limit was reached. Case true, it throws.
   */
  modifier limitedPayable() {
    require(address(this).balance <= limit);
    _;

  }

}
