// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-b4acf144c10b1d9f3ecde4ee2820931df1cb8e4a/contracts/core/interfaces/ISetFactory.sol

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

pragma solidity 0.5.4;


/**
 * @title ISetFactory
 * @author Set Protocol
 *
 * The ISetFactory interface provides operability for authorized contracts
 * to interact with SetTokenFactory
 */
interface ISetFactory {

    /* ============ External Functions ============ */

    /**
     * Return core address
     *
     * @return address        core address
     */
    function core()
        external
        returns (address);

    /**
     * Deploys a new Set Token and adds it to the valid list of SetTokens
     *
     * @param  _components           The address of component tokens
     * @param  _units                The units of each component token
     * @param  _naturalUnit          The minimum unit to be issued or redeemed
     * @param  _name                 The bytes32 encoded name of the new Set
     * @param  _symbol               The bytes32 encoded symbol of the new Set
     * @param  _callData             Byte string containing additional call parameters
     * @return setTokenAddress       The address of the new Set
     */
    function createSet(
        address[] calldata _components,
        uint[] calldata _units,
        uint256 _naturalUnit,
        bytes32 _name,
        bytes32 _symbol,
        bytes calldata _callData
    )
        external
        returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-b4acf144c10b1d9f3ecde4ee2820931df1cb8e4a/contracts/core/interfaces/IWhiteList.sol

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

pragma solidity 0.5.4;

/**
 * @title IWhiteList
 * @author Set Protocol
 *
 * The IWhiteList interface exposes the whitelist mapping to check components
 */
interface IWhiteList {

    /* ============ External Functions ============ */

    /**
     * Validates address against white list
     *
     * @param  _address       Address to check
     * @return bool           Whether passed in address is whitelisted
     */
    function whiteList(
        address _address
    )
        external
        view
        returns (bool);

    /**
     * Verifies an array of addresses against the whitelist
     *
     * @param  _addresses    Array of addresses to verify
     * @return bool          Whether all addresses in the list are whitelsited
     */
    function areValidAddresses(
        address[] calldata _addresses
    )
        external
        view
        returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-setprotocol/set-protocol-contracts-b4acf144c10b1d9f3ecde4ee2820931df1cb8e4a/contracts/core/interfaces/IRebalancingSetFactory.sol

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

pragma solidity 0.5.4;


/**
 * @title IRebalancingSetFactory
 * @author Set Protocol
 *
 * The IRebalancingSetFactory interface provides operability for authorized contracts
 * to interact with RebalancingSetTokenFactory
 */
contract IRebalancingSetFactory is
    ISetFactory
{
    /**
     * Getter for minimumRebalanceInterval of RebalancingSetTokenFactory, used
     * to enforce rebalanceInterval when creating a RebalancingSetToken
     *
     * @return uint256    Minimum amount of time between rebalances in seconds
     */
    function minimumRebalanceInterval()
        external
        returns (uint256);

    /**
     * Getter for minimumProposalPeriod of RebalancingSetTokenFactory, used
     * to enforce proposalPeriod when creating a RebalancingSetToken
     *
     * @return uint256    Minimum amount of time users can review proposals in seconds
     */
    function minimumProposalPeriod()
        external
        returns (uint256);

    /**
     * Getter for minimumTimeToPivot of RebalancingSetTokenFactory, used
     * to enforce auctionTimeToPivot when proposing a rebalance
     *
     * @return uint256    Minimum amount of time before auction pivot reached
     */
    function minimumTimeToPivot()
        external
        returns (uint256);

    /**
     * Getter for maximumTimeToPivot of RebalancingSetTokenFactory, used
     * to enforce auctionTimeToPivot when proposing a rebalance
     *
     * @return uint256    Maximum amount of time before auction pivot reached
     */
    function maximumTimeToPivot()
        external
        returns (uint256);

    /**
     * Getter for minimumNaturalUnit of RebalancingSetTokenFactory
     *
     * @return uint256    Minimum natural unit
     */
    function minimumNaturalUnit()
        external
        returns (uint256);

    /**
     * Getter for maximumNaturalUnit of RebalancingSetTokenFactory
     *
     * @return uint256    Maximum Minimum natural unit
     */
    function maximumNaturalUnit()
        external
        returns (uint256);

    /**
     * Getter for rebalanceAuctionModule address on RebalancingSetTokenFactory
     *
     * @return address      Address of rebalanceAuctionModule
     */
    function rebalanceAuctionModule()
        external
        returns (address);
}
