// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-b4acf144c10b1d9f3ecde4ee2820931df1cb8e4a/contracts/external/KyberNetwork/KyberNetworkProxyInterface.sol

pragma solidity 0.5.4;


/// @title Kyber Network interface
interface KyberNetworkProxyInterface {
    function getExpectedRate(
      address src,
      address dest,
      uint256 srcQty
    )
      external
      view
      returns (uint256 expectedRate, uint256 slippageRate);

    function trade(
      address src,
      uint srcAmount,
      address dest,
      address destAddress,
      uint maxDestAmount,
      uint minConversionRate,
      address walletId
    )
      external
      payable
      returns (uint);
}
