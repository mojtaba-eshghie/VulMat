// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/IStorageUtils.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IStorageUtils {
    event StoredTemplate(
        bytes32 indexed templateId,
        bytes32 endpointId,
        bytes parameters
    );

    event StoredSubscription(
        bytes32 indexed subscriptionId,
        uint256 chainId,
        address airnode,
        bytes32 templateId,
        bytes parameters,
        bytes conditions,
        address relayer,
        address sponsor,
        address requester,
        bytes4 fulfillFunctionId
    );

    function storeTemplate(bytes32 endpointId, bytes calldata parameters)
        external
        returns (bytes32 templateId);

    function storeSubscription(
        uint256 chainId,
        address airnode,
        bytes32 templateId,
        bytes calldata parameters,
        bytes calldata conditions,
        address relayer,
        address sponsor,
        address requester,
        bytes4 fulfillFunctionId
    ) external returns (bytes32 subscriptionId);

    // solhint-disable-next-line func-name-mixedcase
    function MAXIMUM_PARAMETER_LENGTH() external view returns (uint256);

    function templates(bytes32 templateId)
        external
        view
        returns (bytes32 endpointId, bytes memory parameters);

    function subscriptions(bytes32 subscriptionId)
        external
        view
        returns (
            uint256 chainId,
            address airnode,
            bytes32 templateId,
            bytes memory parameters,
            bytes memory conditions,
            address relayer,
            address sponsor,
            address requester,
            bytes4 fulfillFunctionId
        );
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/ISponsorshipUtils.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface ISponsorshipUtils {
    event SetRrpSponsorshipStatus(
        address indexed sponsor,
        address indexed requester,
        bool status
    );

    event SetPspSponsorshipStatus(
        address indexed sponsor,
        bytes32 indexed subscriptionId,
        bool status
    );

    function setRrpSponsorshipStatus(address requester, bool status) external;

    function setPspSponsorshipStatus(bytes32 subscriptionId, bool status)
        external;

    function sponsorToRequesterToRrpSponsorshipStatus(
        address sponsor,
        address requester
    ) external view returns (bool status);

    function sponsorToSubscriptionIdToPspSponsorshipStatus(
        address sponsor,
        bytes32 subscriptionId
    ) external view returns (bool status);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/IWithdrawalUtils.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IWithdrawalUtils {
    event RequestedWithdrawal(
        address indexed airnodeOrRelayer,
        address indexed sponsor,
        bytes32 indexed withdrawalRequestId,
        uint256 protocolId
    );

    event FulfilledWithdrawal(
        address indexed airnodeOrRelayer,
        address indexed sponsor,
        bytes32 indexed withdrawalRequestId,
        uint256 protocolId,
        address sponsorWallet,
        uint256 amount
    );

    event ClaimedBalance(address indexed sponsor, uint256 amount);

    function requestWithdrawal(address airnodeOrRelayer, uint256 protocolId)
        external;

    function fulfillWithdrawal(
        bytes32 withdrawalRequestId,
        address airnodeOrRelayer,
        uint256 protocolId,
        address sponsor,
        uint256 timestamp,
        bytes calldata signature
    ) external payable;

    function claimBalance() external;

    function withdrawalRequestIsAwaitingFulfillment(bytes32 withdrawalRequestId)
        external
        view
        returns (bool);

    function sponsorToBalance(address sponsor) external view returns (uint256);

    function sponsorToWithdrawalRequestCount(address sponsor)
        external
        view
        returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/protocol/interfaces/IAirnodeProtocol.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;



interface IAirnodeProtocol is
    IStorageUtils,
    ISponsorshipUtils,
    IWithdrawalUtils
{
    event MadeRequest(
        address indexed airnode,
        bytes32 indexed requestId,
        address requester,
        uint256 requesterRequestCount,
        bytes32 templateId,
        bytes parameters,
        address sponsor,
        bytes4 fulfillFunctionId
    );

    event FulfilledRequest(
        address indexed airnode,
        bytes32 indexed requestId,
        uint256 timestamp,
        bytes data
    );

    event FailedRequest(
        address indexed airnode,
        bytes32 indexed requestId,
        uint256 timestamp,
        string errorMessage
    );

    event MadeRequestRelayed(
        address indexed relayer,
        bytes32 indexed requestId,
        address indexed airnode,
        address requester,
        uint256 requesterRequestCount,
        bytes32 templateId,
        bytes parameters,
        address sponsor,
        bytes4 fulfillFunctionId
    );

    event FulfilledRequestRelayed(
        address indexed relayer,
        bytes32 indexed requestId,
        address indexed airnode,
        uint256 timestamp,
        bytes data
    );

    event FailedRequestRelayed(
        address indexed relayer,
        bytes32 indexed requestId,
        address indexed airnode,
        uint256 timestamp,
        string errorMessage
    );

    function makeRequest(
        address airnode,
        bytes32 templateId,
        bytes calldata parameters,
        address sponsor,
        bytes4 fulfillFunctionId
    ) external returns (bytes32 requestId);

    function fulfillRequest(
        bytes32 requestId,
        address airnode,
        address requester,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external returns (bool callSuccess, bytes memory callData);

    function failRequest(
        bytes32 requestId,
        address airnode,
        address requester,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        string calldata errorMessage,
        bytes calldata signature
    ) external;

    function makeRequestRelayed(
        address airnode,
        bytes32 templateId,
        bytes calldata parameters,
        address relayer,
        address sponsor,
        bytes4 fulfillFunctionId
    ) external returns (bytes32 requestId);

    function fulfillRequestRelayed(
        bytes32 requestId,
        address airnode,
        address requester,
        address relayer,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        bytes calldata data,
        bytes calldata signature
    ) external returns (bool callSuccess, bytes memory callData);

    function failRequestRelayed(
        bytes32 requestId,
        address airnode,
        address requester,
        address relayer,
        bytes4 fulfillFunctionId,
        uint256 timestamp,
        string calldata errorMessage,
        bytes calldata signature
    ) external;

    function requestIsAwaitingFulfillment(bytes32 requestId)
        external
        view
        returns (bool);

    function requesterToRequestCount(address requester)
        external
        view
        returns (uint256);
}
