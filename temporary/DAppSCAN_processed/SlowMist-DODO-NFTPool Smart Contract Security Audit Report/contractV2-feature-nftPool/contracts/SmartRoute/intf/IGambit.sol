// File: ../sc_datasets/DAppSCAN/SlowMist-DODO-NFTPool Smart Contract Security Audit Report/contractV2-feature-nftPool/contracts/SmartRoute/intf/IGambit.sol

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

interface IGambit {
    function swap(address _tokenIn, address _tokenOut, address _receiver) external returns (uint256);
}
