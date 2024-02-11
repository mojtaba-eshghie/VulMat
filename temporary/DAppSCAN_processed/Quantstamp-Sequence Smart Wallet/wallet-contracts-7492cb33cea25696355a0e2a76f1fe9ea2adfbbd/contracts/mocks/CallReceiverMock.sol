// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/mocks/CallReceiverMock.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


contract CallReceiverMock {
  uint256 public lastValA;
  bytes public lastValB;

  bool revertFlag;

  constructor() public payable { }

  function setRevertFlag(bool _revertFlag) external {
    revertFlag = _revertFlag;
  }

  function testCall(uint256 _valA, bytes calldata _valB) external payable {
    require(!revertFlag, "CallReceiverMock#testCall: REVERT_FLAG");

    lastValA = _valA;
    lastValB = _valB;
  }
}
