// File: ../sc_datasets/DAppSCAN/Coinfabrik-Polymath Core Audit/polymath-core-dev-3.1.0/contracts/interfaces/IOracle.sol

pragma solidity 0.5.8;

interface IOracle {
    /**
    * @notice Returns address of oracle currency (0x0 for ETH)
    */
    function getCurrencyAddress() external view returns(address currency);

    /**
    * @notice Returns symbol of oracle currency (0x0 for ETH)
    */
    function getCurrencySymbol() external view returns(bytes32 symbol);

    /**
    * @notice Returns denomination of price
    */
    function getCurrencyDenominated() external view returns(bytes32 denominatedCurrency);

    /**
    * @notice Returns price - should throw if not valid
    */
    function getPrice() external returns(uint256 price);

}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Polymath Core Audit/polymath-core-dev-3.1.0/contracts/mocks/MockOracle.sol

pragma solidity 0.5.8;

contract MockOracle is IOracle {
    address public currency;
    bytes32 public currencySymbol;
    bytes32 public denominatedCurrency;
    uint256 public price;

    constructor(address _currency, bytes32 _currencySymbol, bytes32 _denominatedCurrency, uint256 _price) public {
        currency = _currency;
        currencySymbol = _currencySymbol;
        denominatedCurrency = _denominatedCurrency;
        price = _price;
    }

    function changePrice(uint256 _price) external {
        price = _price;
    }

    /**
    * @notice Returns address of oracle currency (0x0 for ETH)
    */
    function getCurrencyAddress() external view returns(address) {
        return currency;
    }

    /**
    * @notice Returns symbol of oracle currency (0x0 for ETH)
    */
    function getCurrencySymbol() external view returns(bytes32) {
        return currencySymbol;
    }

    /**
    * @notice Returns denomination of price
    */
    function getCurrencyDenominated() external view returns(bytes32) {
        return denominatedCurrency;
    }

    /**
    * @notice Returns price - should throw if not valid
    */
    function getPrice() external returns(uint256) {
        return price;
    }

}
