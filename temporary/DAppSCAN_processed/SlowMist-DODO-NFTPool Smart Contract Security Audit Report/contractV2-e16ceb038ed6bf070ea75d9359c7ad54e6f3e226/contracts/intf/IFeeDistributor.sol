// File: ../sc_datasets/DAppSCAN/SlowMist-DODO-NFTPool Smart Contract Security Audit Report/contractV2-e16ceb038ed6bf070ea75d9359c7ad54e6f3e226/contracts/intf/IFeeDistributor.sol

/*

    Copyright 2020 DODO ZOO.
    SPDX-License-Identifier: Apache-2.0

*/

pragma solidity 0.6.9;

interface IFeeDistributor {
    function init(
      address baseToken,
      address quoteToken,
      address stakeToken
    ) external;

    function stake(address to) external;

    function _STAKE_TOKEN_() external view returns(address);

    function _STAKE_VAULT_() external view returns(address);

}
