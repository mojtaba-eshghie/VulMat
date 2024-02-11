// File: ../sc_datasets/DAppSCAN/QuillAudits-MetaGameStarter Smart Contract/Tokenomics-Contracts-f3899d0a31dbb7386eacb7efefbff2ac32ce7cbb/contracts/Vesting/IvestingMinimal.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IvestingMinimal {

  function initialize (
    address _token,
    address _owner,
    uint256 _startInDays,
    uint256 _durationInDays,
    uint256 _cliffInTenThousands,
    uint256 _cliffDelayInDays,
    uint exp
  ) external;
}
