// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FujiProtocol/fuji-protocol-933ea57b11889d87744efa23e95c90b7bf589402/contracts/interfaces/IFujiOracle.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IFujiOracle {
  function getPriceOf(
    address _collateralAsset,
    address _borrowAsset,
    uint8 _decimals
  ) external view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FujiProtocol/fuji-protocol-933ea57b11889d87744efa23e95c90b7bf589402/contracts/mocks/FujiOracleMock.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FujiOracleMock is IFujiOracle {
  mapping(address => mapping(address => uint256)) public prices;

  function setPriceOf(
    address _collateralAsset,
    address _borrowAsset,
    uint256 _price
  ) external {
    prices[_collateralAsset][_borrowAsset] = _price;
  }

  function getPriceOf(
    address _collateralAsset,
    address _borrowAsset,
    uint8
  ) external view override returns (uint256) {
    return prices[_collateralAsset][_borrowAsset];
  }
}
