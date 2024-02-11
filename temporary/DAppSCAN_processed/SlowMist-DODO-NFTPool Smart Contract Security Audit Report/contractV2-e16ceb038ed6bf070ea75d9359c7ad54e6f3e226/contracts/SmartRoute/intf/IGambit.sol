// File: ../sc_datasets/DAppSCAN/SlowMist-DODO-NFTPool Smart Contract Security Audit Report/contractV2-e16ceb038ed6bf070ea75d9359c7ad54e6f3e226/contracts/SmartRoute/intf/IGambit.sol

pragma solidity 0.6.9;
pragma experimental ABIEncoderV2;

interface IGambit {
    function swap(address _tokenIn, address _tokenOut, address _receiver) external returns (uint256);
}
