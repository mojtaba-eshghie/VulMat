// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/interfaces/IPriceOracle.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

/************
@title IPriceOracle interface
@notice Interface for the Aave price oracle.*/
interface IPriceOracle {
  /***********
    @dev returns the asset price in ETH
     */
  function getAssetPrice(address asset) external view returns (uint256);

  /***********
    @dev sets the asset price, in wei
     */
  function setAssetPrice(address asset, uint256 price) external;
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-Aave stETH/aave-protocol-v2-12c9111990c9699e84a36f30ba849486ef8f2a84/contracts/mocks/oracle/PriceOracle.sol

// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

contract PriceOracle is IPriceOracle {
  mapping(address => uint256) prices;
  uint256 ethPriceUsd;

  event AssetPriceUpdated(address _asset, uint256 _price, uint256 timestamp);
  event EthPriceUpdated(uint256 _price, uint256 timestamp);

  function getAssetPrice(address _asset) external view override returns (uint256) {
    return prices[_asset];
  }

  function setAssetPrice(address _asset, uint256 _price) external override {
    prices[_asset] = _price;
    emit AssetPriceUpdated(_asset, _price, block.timestamp);
  }

  function getEthUsdPrice() external view returns (uint256) {
    return ethPriceUsd;
  }

  function setEthUsdPrice(uint256 _price) external {
    ethPriceUsd = _price;
    emit EthPriceUpdated(_price, block.timestamp);
  }
}
