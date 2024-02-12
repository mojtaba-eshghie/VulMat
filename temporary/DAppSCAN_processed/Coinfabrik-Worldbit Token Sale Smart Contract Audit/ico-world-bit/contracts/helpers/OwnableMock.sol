// File: ../sc_datasets/DAppSCAN/Coinfabrik-Worldbit Token Sale Smart Contract Audit/ico-world-bit/contracts/Ownable.sol

pragma solidity ^0.4.18;

/**
 * Originally from https://github.com/OpenZeppelin/zeppelin-solidity
 * Modified by https://www.coinfabrik.com/
 */

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control 
 * functions, this simplifies the implementation of "user permissions". 
 */
contract Ownable {
  address public owner;


  /** 
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() internal {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner. 
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to. 
   */
  function transferOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    owner = newOwner;
  }

}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Worldbit Token Sale Smart Contract Audit/ico-world-bit/contracts/helpers/OwnableMock.sol

pragma solidity ^0.4.18;

// Mock class for Ownable contract
contract OwnableMock is Ownable {

  function OwnableMock() public {
  }

}