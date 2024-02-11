// File: ../sc_datasets/DAppSCAN/Hacken-Splash/splash-core-b38add0749f450a528197909005f6666cf609960/src/interfaces/IRNG.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IRNG {
  function requestBlockRandom(address caller) external;
  function checkBlockRandom(address caller) external;
  function getBlockRandom(address caller) external view returns(uint256);
  function resetBlockRandom(address caller) external;

  function requestChainlinkRandom(address caller) external returns(bytes32 requestId);
  function getChainlinkRandom(address caller) external view returns(uint256);
  function resetChainlinkRandom(address caller) external;
}
