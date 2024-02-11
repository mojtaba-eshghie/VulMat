// File: ../sc_datasets/DAppSCAN/PeckShield-TranchessV1.1/contract-core-68a86350313c1cb9e5467e791d3e9efaf228a0df/contracts/governance/AddressWhitelist.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.6.10 <0.8.0;

contract AddressWhitelist {
    mapping(address => bool) public whitelist;

    constructor(address[] memory whitelistAccounts) public {
        for (uint256 i = 0; i < whitelistAccounts.length; i++) {
            whitelist[whitelistAccounts[i]] = true;
        }
    }

    function check(address account) external view returns (bool) {
        return whitelist[account];
    }
}
