// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Aave Protocol V2/protocol-v2-750920303e33b66bc29862ea3b85206dda9ce786/contracts/mocks/attacks/SefldestructTransfer.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

contract SelfdestructTransfer {
  function destroyAndTransfer(address payable to) external payable {
    selfdestruct(to);
  }
}
