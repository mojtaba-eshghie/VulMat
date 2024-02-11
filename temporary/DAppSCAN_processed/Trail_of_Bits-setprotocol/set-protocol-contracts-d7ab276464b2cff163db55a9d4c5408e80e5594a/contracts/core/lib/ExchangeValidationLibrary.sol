// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-d7ab276464b2cff163db55a9d4c5408e80e5594a/contracts/core/interfaces/ISetToken.sol

/*
    Copyright 2018 Set Labs Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

pragma solidity 0.4.25;

/**
 * @title ISetToken
 * @author Set Protocol
 *
 * The ISetToken interface provides a light-weight, structured way to interact with the
 * SetToken contract from another contract.
 */
interface ISetToken {

    /* ============ External Functions ============ */

    /*
     * Get natural unit of Set
     *
     * @return  uint256       Natural unit of Set
     */
    function naturalUnit()
        external
        view
        returns (uint256);

    /*
     * Get addresses of all components in the Set
     *
     * @return  componentAddresses       Array of component tokens
     */
    function getComponents()
        external
        view
        returns(address[]);

    /*
     * Get units of all tokens in Set
     *
     * @return  units       Array of component units
     */
    function getUnits()
        external
        view
        returns(uint256[]);

    /*
     * Checks to make sure token is component of Set
     *
     * @param  _tokenAddress     Address of token being checked
     * @return  bool             True if token is component of Set
     */
    function tokenIsComponent(
        address _tokenAddress
    )
        external
        view
        returns (bool);

    /*
     * Mint set token for given address.
     * Can only be called by authorized contracts.
     *
     * @param  _issuer      The address of the issuing account
     * @param  _quantity    The number of sets to attribute to issuer
     */
    function mint(
        address _issuer,
        uint256 _quantity
    )
        external;

    /*
     * Burn set token for given address
     * Can only be called by authorized contracts
     *
     * @param  _from        The address of the redeeming account
     * @param  _quantity    The number of sets to burn from redeemer
     */
    function burn(
        address _from,
        uint256 _quantity
    )
        external;

    /**
    * Transfer token for a specified address
    *
    * @param to The address to transfer to.
    * @param value The amount to be transferred.
    */
    function transfer(
        address to,
        uint256 value
    )
        external;
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-d7ab276464b2cff163db55a9d4c5408e80e5594a/contracts/core/interfaces/IVault.sol

/*
    Copyright 2018 Set Labs Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

pragma solidity 0.4.25;

/**
 * @title IVault
 * @author Set Protocol
 *
 * The IVault interface provides a light-weight, structured way to interact with the Vault
 * contract from another contract.
 */
interface IVault {

    /*
     * Withdraws user's unassociated tokens to user account. Can only be
     * called by authorized core contracts.
     *
     * @param  _token          The address of the ERC20 token
     * @param  _to             The address to transfer token to
     * @param  _quantity       The number of tokens to transfer
     */
    function withdrawTo(
        address _token,
        address _to,
        uint256 _quantity
    )
        external;

    /*
     * Increment quantity owned of a token for a given address. Can
     * only be called by authorized core contracts.
     *
     * @param  _token           The address of the ERC20 token
     * @param  _owner           The address of the token owner
     * @param  _quantity        The number of tokens to attribute to owner
     */
    function incrementTokenOwner(
        address _token,
        address _owner,
        uint256 _quantity
    )
        external;

    /*
     * Decrement quantity owned of a token for a given address. Can only
     * be called by authorized core contracts.
     *
     * @param  _token           The address of the ERC20 token
     * @param  _owner           The address of the token owner
     * @param  _quantity        The number of tokens to deattribute to owner
     */
    function decrementTokenOwner(
        address _token,
        address _owner,
        uint256 _quantity
    )
        external;

    /**
     * Transfers tokens associated with one account to another account in the vault
     *
     * @param  _token          Address of token being transferred
     * @param  _from           Address token being transferred from
     * @param  _to             Address token being transferred to
     * @param  _quantity       Amount of tokens being transferred
     */

    function transferBalance(
        address _token,
        address _from,
        address _to,
        uint256 _quantity
    )
        external;


    /*
     * Withdraws user's unassociated tokens to user account. Can only be
     * called by authorized core contracts.
     *
     * @param  _tokens          The addresses of the ERC20 tokens
     * @param  _owner           The address of the token owner
     * @param  _quantities      The numbers of tokens to attribute to owner
     */
    function batchWithdrawTo(
        address[] _tokens,
        address _to,
        uint256[] _quantities
    )
        external;

    /*
     * Increment quantites owned of a collection of tokens for a given address. Can
     * only be called by authorized core contracts.
     *
     * @param  _tokens          The addresses of the ERC20 tokens
     * @param  _owner           The address of the token owner
     * @param  _quantities      The numbers of tokens to attribute to owner
     */
    function batchIncrementTokenOwner(
        address[] _tokens,
        address _owner,
        uint256[] _quantities
    )
        external;

    /*
     * Decrements quantites owned of a collection of tokens for a given address. Can
     * only be called by authorized core contracts.
     *
     * @param  _tokens          The addresses of the ERC20 tokens
     * @param  _owner           The address of the token owner
     * @param  _quantities      The numbers of tokens to attribute to owner
     */
    function batchDecrementTokenOwner(
        address[] _tokens,
        address _owner,
        uint256[] _quantities
    )
        external;

   /**
     * Transfers tokens associated with one account to another account in the vault
     *
     * @param  _tokens           Addresses of tokens being transferred
     * @param  _from             Address tokens being transferred from
     * @param  _to               Address tokens being transferred to
     * @param  _quantities       Amounts of tokens being transferred
     */
    function batchTransferBalance(
        address[] _tokens,
        address _from,
        address _to,
        uint256[] _quantities
    )
        external;

    /*
     * Get balance of particular contract for owner.
     *
     * @param  _token    The address of the ERC20 token
     * @param  _owner    The address of the token owner
     */
    function getOwnerBalance(
        address _token,
        address _owner
    )
        external
        returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-d7ab276464b2cff163db55a9d4c5408e80e5594a/contracts/core/lib/ExchangeValidationLibrary.sol

/*
    Copyright 2018 Set Labs Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

pragma solidity 0.4.25;


/**
 * @title ExchangeValidationLibrary
 * @author Set Protocol
 *
 * The ExchangeValidationLibrary contains functions for validating exchange order data
 */
library ExchangeValidationLibrary {

    /**
     * Validates that the quantity to issue is positive and a multiple of the Set natural unit.
     *
     * @param _set                The address of the Set
     * @param _quantity           The quantity of Sets to issue
     */
    function validateIssueQuantity(
        address _set,
        uint256 _quantity
    )
        internal
        view
    {
        // Make sure quantity to issue is greater than 0
        require(
            _quantity > 0,
            "ExchangeValidationLibrary.validateIssueQuantity: Quantity must be positive"
        );

        // Make sure Issue quantity is multiple of the Set natural unit
        require(
            _quantity % ISetToken(_set).naturalUnit() == 0,
            "ExchangeValidationLibrary.validateIssueQuantity: Quantity must be multiple of natural unit"
        );
    }

    /**
     * Validates that the required Components and amounts are valid components and positive
     *
     * @param _set                          The address of the Set
     * @param _requiredComponents           The addresses of components required for issuance
     * @param _requiredComponentAmounts     The quantities of components required for issuance
     */
    function validateRequiredComponents(
        address _set,
        address[] _requiredComponents,
        uint256[] _requiredComponentAmounts
    )
        internal
        view
    {
        uint256 requiredComponentsCount = _requiredComponents.length;

        // Make sure required components array is non-empty
        require(
            requiredComponentsCount > 0,
            "ExchangeValidationLibrary.validateRequiredComponents: Required components must not be empty"
        );

        // Make sure required components and required component amounts are equal length
        require(
            requiredComponentsCount == _requiredComponentAmounts.length,
            "ExchangeValidationLibrary.validateRequiredComponents: Required components and amounts must be equal length"
        );

        for (uint256 i = 0; i < requiredComponentsCount; i++) {
            // Make sure all required components are members of the Set
            require(
                ISetToken(_set).tokenIsComponent(_requiredComponents[i]),
                "ExchangeValidationLibrary.validateRequiredComponents: Component must be a member of Set");

            // Make sure all required component amounts are non-zero
            require(
                _requiredComponentAmounts[i] > 0,
                "ExchangeValidationLibrary.validateRequiredComponents: Component amounts must be positive"
            );
        }
    }

    /**
     * Validates that the tokens used during issuance does not exceed tokens available
     *
     * @param _tokensUsed                The quantities of payment or maker token used
     * @param _tokensAvailable           The quantities of payment or maker token available
     */
    function validateTokenUsage(
        uint256 _tokensUsed,
        uint256 _tokensAvailable
    )
        internal
        view
    {
        // Verify token used is less than amount allocated
        require(
            _tokensUsed <= _tokensAvailable,
            "ExchangeValidationLibrary.validateTokenUsage: Payment token used exceeds allotted limit"
        );
    }

    /**
     * Validates that the tokens used during issuance does not exceed tokens available
     *
     * @param _vault                        The address of the Vault
     * @param _requiredComponents           The addresses of components required for issuance
     * @param _requiredBalances             The quantities of components required for issuance
     * @param _userToCheck                  The address of the user
     */
    function validateRequiredComponentBalances(
        address _vault,
        address[] _requiredComponents,
        uint256[] _requiredBalances,
        address _userToCheck
    )
        internal
        view
    {
        // Get vault instance
        IVault vault = IVault(_vault);

        // Check that maker's component tokens in Vault have been incremented correctly
        for (uint256 i = 0; i < _requiredComponents.length; i++) {
            uint256 currentBal = vault.getOwnerBalance(
                _requiredComponents[i],
                _userToCheck
            );

            require(
                currentBal >= _requiredBalances[i],
                "ExchangeValidationLibrary.validateRequiredComponentBalances: Insufficient component tokens acquired"
            );
        }
    }
}
