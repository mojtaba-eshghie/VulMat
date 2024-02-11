// File: ../sc_datasets/DAppSCAN/Quantstamp-RariCapital V2/rari-stable-pool-contracts-7f351ca3df72a0196f3640f30a6db73660ab1467/contracts/external/dydx/lib/Account.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.5.17;
pragma experimental ABIEncoderV2;

/**
 * @title Account
 * @author dYdX
 *
 * Library of structs and functions that represent an account
 */
library Account {
    // Represents the unique key that specifies an account
    struct Info {
        address owner;  // The address that owns the account
        uint256 number; // A nonce that allows a single address to control many accounts
    }
}
