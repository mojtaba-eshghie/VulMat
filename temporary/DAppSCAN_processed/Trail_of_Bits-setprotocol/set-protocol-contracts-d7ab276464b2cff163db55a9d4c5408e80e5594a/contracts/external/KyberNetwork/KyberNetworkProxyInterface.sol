// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-d7ab276464b2cff163db55a9d4c5408e80e5594a/contracts/external/KyberNetwork/KyberNetworkProxyInterface.sol

pragma solidity 0.4.25;


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
      returns(uint);
}
