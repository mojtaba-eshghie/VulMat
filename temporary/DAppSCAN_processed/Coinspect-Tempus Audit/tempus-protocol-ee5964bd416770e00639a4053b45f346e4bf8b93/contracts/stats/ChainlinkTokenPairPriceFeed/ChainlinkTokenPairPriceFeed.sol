// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/stats/ChainlinkTokenPairPriceFeed/IChainlinkAggregator.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.6;

// Based on Chainlink's AggregatorV3Interface.sol
// https://github.com/smartcontractkit/chainlink/blob/master/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol
interface IChainlinkAggregator {
    function decimals() external view returns (uint8);

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/stats/ChainlinkTokenPairPriceFeed/IENS.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;

// Based on https://github.com/ensdomains/ens/blob/master/contracts/ENS.sol
interface IENS {
    function resolver(bytes32 node) external view returns (IENSResolver);
}

// Based on https://github.com/ensdomains/resolvers/blob/master/contracts/profiles/AddrResolver.sol
interface IENSResolver {
    function addr(bytes32 node) external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/stats/ITokenPairPriceFeed.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;

interface ITokenPairPriceFeed {
    /// @dev Fetches the rate between a given token pair
    /// @param rateConversionData data that specifies the target tokens (each ITokenPairPriceFeed might have different input requirements)
    /// @return rate - The rate between the provided tokens
    /// @return rateDenominator
    function getRate(bytes32 rateConversionData) external view returns (uint256 rate, uint256 rateDenominator);
}

// File: ../sc_datasets/DAppSCAN/Coinspect-Tempus Audit/tempus-protocol-ee5964bd416770e00639a4053b45f346e4bf8b93/contracts/stats/ChainlinkTokenPairPriceFeed/ChainlinkTokenPairPriceFeed.sol

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;



abstract contract ChainlinkTokenPairPriceFeed is ITokenPairPriceFeed {
    // The ENS registry (same for mainnet and all major test nets)
    IENS public constant ENS = IENS(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);

    function getRate(bytes32 chainlinkAggregatorNodeHash)
        public
        view
        override
        returns (uint256 rate, uint256 rateDenominator)
    {
        IENSResolver ensResolver = ENS.resolver(chainlinkAggregatorNodeHash);
        IChainlinkAggregator chainLinkAggregator = IChainlinkAggregator(ensResolver.addr(chainlinkAggregatorNodeHash));

        (, int256 latestRate, , , ) = chainLinkAggregator.latestRoundData();

        require(latestRate >= 0, "latest chainlink rate too small"); // prevents underflow when casting to uint256

        return (uint256(latestRate), 10**chainLinkAggregator.decimals());
    }
}
