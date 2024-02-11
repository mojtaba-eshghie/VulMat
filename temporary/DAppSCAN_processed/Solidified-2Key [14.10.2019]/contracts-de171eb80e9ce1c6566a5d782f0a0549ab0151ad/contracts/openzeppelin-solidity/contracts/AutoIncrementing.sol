// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/AutoIncrementing.sol

pragma solidity ^0.4.24;


/**
 * @title AutoIncrementing
 * @author Matt Condon (@shrugs)
 * @dev Provides an auto-incrementing uint256 id acquired by the `Counter#nextId` getter.
 * Use this for issuing ERC721Token ids or keeping track of request ids, anything you want, really.
 *
 * Include with `using AutoIncrementing for AutoIncrementing.Counter;`
 * @notice Does not allow an Id of 0, which is popularly used to signify a null state in solidity.
 * Does not protect from overflows, but if you have 2^256 ids, you have other problems.
 * (But actually, it's generally impossible to increment a counter this many times, energy wise
 * so it's not something you have to worry about.)
 */
library AutoIncrementing {

  struct Counter {
    uint256 prevId; // default: 0
  }

  function nextId(Counter storage _counter)
    internal
    returns (uint256)
  {
    _counter.prevId = _counter.prevId + 1;
    return _counter.prevId;
  }
}
