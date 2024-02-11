// File: ../sc_datasets/DAppSCAN/SlowMist-DODO-MiningV3 and NFT Smart Contract Security Audit Report/contractV2-feature-nft/contracts/intf/IFeeDistributor.sol

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
