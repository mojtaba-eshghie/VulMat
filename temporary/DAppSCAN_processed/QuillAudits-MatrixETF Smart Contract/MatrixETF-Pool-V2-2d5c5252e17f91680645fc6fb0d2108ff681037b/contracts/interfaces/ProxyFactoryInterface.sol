// File: ../sc_datasets/DAppSCAN/QuillAudits-MatrixETF Smart Contract/MatrixETF-Pool-V2-2d5c5252e17f91680645fc6fb0d2108ff681037b/contracts/interfaces/ProxyFactoryInterface.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

interface ProxyFactoryInterface {
  function build(
    address _impl,
    address proxyAdmin,
    bytes calldata _data
  ) external returns (address);
}
