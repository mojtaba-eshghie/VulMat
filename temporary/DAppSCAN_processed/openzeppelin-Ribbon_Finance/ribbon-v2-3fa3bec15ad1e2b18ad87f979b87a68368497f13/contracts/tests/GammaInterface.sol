// File: ../sc_datasets/DAppSCAN/openzeppelin-Ribbon_Finance/ribbon-v2-3fa3bec15ad1e2b18ad87f979b87a68368497f13/contracts/tests/GammaInterface.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.7.2;

interface IGammaWhitelist {
    function whitelistCollateral(address _collateral) external;

    function whitelistProduct(
        address _underlying,
        address _strike,
        address _collateral,
        bool _isPut
    ) external;
}
