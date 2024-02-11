// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Liquity/dev-f0df3efa5a5f05b205752184cfce107c5bd6e06c/packages/contracts/contracts/Interfaces/IPriceFeed.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

interface IPriceFeed {

    function getPrice() external view returns (uint);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Liquity/dev-f0df3efa5a5f05b205752184cfce107c5bd6e06c/packages/contracts/contracts/TestContracts/PriceFeedTestnet.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

/*
* PriceFeed placeholder for testnet and development. The price is simply set manually and saved in a state 
* variable. The contract does not connect to a live Chainlink price feed. 
*/
contract PriceFeedTestnet is IPriceFeed {
    
    uint256 private _price = 200 * 1e18;

    // --- Functions ---

    function getPrice() external view override returns (uint256) {
        return _price;
    }

    // Manual external price setter.
    function setPrice(uint256 price) external returns (bool) {
        _price = price;
        return true;
    }
}
