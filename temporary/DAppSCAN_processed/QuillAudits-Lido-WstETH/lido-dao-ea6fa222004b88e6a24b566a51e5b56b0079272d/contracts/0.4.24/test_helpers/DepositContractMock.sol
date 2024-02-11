// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-WstETH/lido-dao-ea6fa222004b88e6a24b566a51e5b56b0079272d/contracts/0.4.24/interfaces/IDepositContract.sol

// SPDX-FileCopyrightText: 2020 Lido <info@lido.fi>

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.24;


/**
  * @title Deposit contract interface
  */
interface IDepositContract {
    /**
      * @notice Top-ups deposit of a validator on the ETH 2.0 side
      * @param pubkey Validator signing key
      * @param withdrawal_credentials Credentials that allows to withdraw funds
      * @param signature Signature of the request
      * @param deposit_data_root The deposits Merkle tree node, used as a checksum
      */
    function deposit(
        bytes /* 48 */ pubkey,
        bytes /* 32 */ withdrawal_credentials,
        bytes /* 96 */ signature,
        bytes32 deposit_data_root
    )
        external payable;
}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Lido-WstETH/lido-dao-ea6fa222004b88e6a24b566a51e5b56b0079272d/contracts/0.4.24/test_helpers/DepositContractMock.sol

// SPDX-FileCopyrightText: 2020 Lido <info@lido.fi>

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.24;

/**
  * @dev This is a mock. Don't use in production.
  */
contract DepositContractMock is IDepositContract {
    struct Call {
        bytes pubkey;
        bytes withdrawal_credentials;
        bytes signature;
        bytes32 deposit_data_root;
        uint256 value;
    }

    Call[] public calls;

    function deposit(
        bytes /* 48 */ pubkey,
        bytes /* 32 */ withdrawal_credentials,
        bytes /* 96 */ signature,
        bytes32 deposit_data_root
    )
        external
        payable
    {
        calls.push(Call(pubkey, withdrawal_credentials, signature, deposit_data_root, msg.value));
    }

    function totalCalls() external view returns (uint256) {
        return calls.length;
    }

    function reset() external {
        calls.length = 0;
    }
}
