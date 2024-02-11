// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/utility/interfaces/IOwned.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/*
    Owned contract interface
*/
interface IOwned {
    // this function isn't since the compiler emits automatically generated getter functions as external
    function owner() external view returns (address);

    function transferOwnership(address _newOwner) external;
    function acceptOwnership() external;
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/converter/interfaces/IConverterAnchor.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/*
    Converter Anchor interface
*/
interface IConverterAnchor is IOwned {
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/token/interfaces/IERC20Token.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;

/*
    ERC20 Standard Token interface
*/
interface IERC20Token {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address _owner) external view returns (uint256);
    function allowance(address _owner, address _spender) external view returns (uint256);

    function transfer(address _to, uint256 _value) external returns (bool);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool);
    function approve(address _spender, uint256 _value) external returns (bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-Zer0_zBanc/zBanc-48da0ac1eebbe31a74742f1ae4281b156f03a4bc/solidity/contracts/converter/interfaces/IConverterRegistryData.sol

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.12;


interface IConverterRegistryData {
    function addSmartToken(IConverterAnchor _anchor) external;
    function removeSmartToken(IConverterAnchor _anchor) external;

    function addLiquidityPool(IConverterAnchor _liquidityPoolAnchor) external;
    function removeLiquidityPool(IConverterAnchor _liquidityPoolAnchor) external;

    function addConvertibleToken(IERC20Token _convertibleToken, IConverterAnchor _anchor) external;
    function removeConvertibleToken(IERC20Token _convertibleToken, IConverterAnchor _anchor) external;

    function getSmartTokenCount() external view returns (uint256);
    function getSmartTokens() external view returns (address[] memory);
    function getSmartToken(uint256 _index) external view returns (IConverterAnchor);
    function isSmartToken(address _value) external view returns (bool);

    function getLiquidityPoolCount() external view returns (uint256);
    function getLiquidityPools() external view returns (address[] memory);
    function getLiquidityPool(uint256 _index) external view returns (IConverterAnchor);
    function isLiquidityPool(address _value) external view returns (bool);

    function getConvertibleTokenCount() external view returns (uint256);
    function getConvertibleTokens() external view returns (address[] memory);
    function getConvertibleToken(uint256 _index) external view returns (IERC20Token);
    function isConvertibleToken(address _value) external view returns (bool);

    function getConvertibleTokenSmartTokenCount(IERC20Token _convertibleToken) external view returns (uint256);
    function getConvertibleTokenSmartTokens(IERC20Token _convertibleToken) external view returns (address[] memory);
    function getConvertibleTokenSmartToken(IERC20Token _convertibleToken, uint256 _index) external view returns (IConverterAnchor);
    function isConvertibleTokenSmartToken(IERC20Token _convertibleToken, address _value) external view returns (bool);
}
