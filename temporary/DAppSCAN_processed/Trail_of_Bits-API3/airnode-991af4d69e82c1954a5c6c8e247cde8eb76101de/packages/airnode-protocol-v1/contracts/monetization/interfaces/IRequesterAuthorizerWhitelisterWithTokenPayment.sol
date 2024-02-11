// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistryUser.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistryUser {
    function accessControlRegistry() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistryAdminned.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistryAdminned is IAccessControlRegistryUser {
    function adminRoleDescription() external view returns (string memory);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/access-control-registry/interfaces/IAccessControlRegistryAdminnedWithManager.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAccessControlRegistryAdminnedWithManager is
    IAccessControlRegistryAdminned
{
    function manager() external view returns (address);

    function adminRole() external view returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/interfaces/IAirnodeEndpointPriceRegistryUser.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IAirnodeEndpointPriceRegistryUser {
    function airnodeEndpointPriceRegistry() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/interfaces/IRequesterAuthorizerRegistryUser.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IRequesterAuthorizerRegistryUser {
    function requesterAuthorizerRegistry() external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/interfaces/IRequesterAuthorizerWhitelisterWithToken.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;



interface IRequesterAuthorizerWhitelisterWithToken is
    IAccessControlRegistryAdminnedWithManager,
    IAirnodeEndpointPriceRegistryUser,
    IRequesterAuthorizerRegistryUser
{
    enum AirnodeParticipationStatus {
        Inactive,
        Active,
        OptedOut
    }

    event SetTokenPrice(uint256 tokenPrice, address sender);

    event SetPriceCoefficient(uint256 priceCoefficient, address sender);

    event SetAirnodeParticipationStatus(
        address airnode,
        AirnodeParticipationStatus airnodeParticipationStatus,
        address sender
    );

    event SetProceedsDestination(address proceedsDestination);

    event SetRequesterBlockStatus(
        address requester,
        bool status,
        address sender
    );

    event SetRequesterBlockStatusForAirnode(
        address airnode,
        address requester,
        bool status,
        address sender
    );

    function setTokenPrice(uint256 _tokenPrice) external;

    function setPriceCoefficient(uint256 _priceCoefficient) external;

    function setAirnodeParticipationStatus(
        address airnode,
        AirnodeParticipationStatus airnodeParticipationStatus
    ) external;

    function setProceedsDestination(address _proceedsDestination) external;

    function setRequesterBlockStatus(address requester, bool status) external;

    function setRequesterBlockStatusForAirnode(
        address airnode,
        address requester,
        bool status
    ) external;

    function getTokenAmount(
        address airnode,
        uint256 chainId,
        bytes32 endpointId
    ) external view returns (uint256 amount);

    function token() external view returns (address);

    function tokenPrice() external view returns (uint256);

    function priceCoefficient() external view returns (uint256);

    function proceedsDestination() external view returns (address);

    function airnodeToParticipationStatus(address airnode)
        external
        view
        returns (AirnodeParticipationStatus);

    function requesterToBlockStatus(address requester)
        external
        view
        returns (bool);

    function airnodeToRequesterToBlockStatus(address airnode, address requester)
        external
        view
        returns (bool);

    // solhint-disable-next-line func-name-mixedcase
    function MAINTAINER_ROLE_DESCRIPTION()
        external
        view
        returns (string memory);

    function maintainerRole() external view returns (bytes32);

    // solhint-disable-next-line func-name-mixedcase
    function BLOCKER_ROLE_DESCRIPTION() external view returns (string memory);

    function blockerRole() external view returns (bytes32);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/monetization/interfaces/IRequesterAuthorizerWhitelisterWithTokenPayment.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IRequesterAuthorizerWhitelisterWithTokenPayment is
    IRequesterAuthorizerWhitelisterWithToken
{
    event PaidTokens(
        address airnode,
        uint256 chainId,
        bytes32 endpointId,
        address requester,
        uint64 whitelistExtension,
        address sender,
        uint64 newExpirationTimestamp
    );

    event ResetWhitelistExpirationOfBlockedRequester(
        address airnode,
        uint256 chainId,
        bytes32 endpointId,
        address requester,
        address sender
    );

    event SetMinimumWhitelistExtension(
        uint64 minimumWhitelistExtension,
        address sender
    );

    event SetMaximumWhitelistDuration(
        uint64 maximumWhitelistDuration,
        address sender
    );

    function payTokens(
        address airnode,
        uint256 chainId,
        bytes32 endpointId,
        address requester,
        uint64 whitelistExtension
    ) external;

    function resetWhitelistExpirationOfBlockedRequester(
        address airnode,
        uint256 chainId,
        bytes32 endpointId,
        address requester
    ) external;

    function setMinimumWhitelistExtension(uint64 _minimumWhitelistExtension)
        external;

    function setMaximumWhitelistDuration(uint64 _maximumWhitelistDuration)
        external;

    function getTokenPaymentAmount(
        address airnode,
        uint256 chainId,
        bytes32 endpointId,
        uint64 whitelistExtension
    ) external view returns (uint256 tokenPaymentAmount);

    function minimumWhitelistExtension() external view returns (uint64);

    function maximumWhitelistDuration() external view returns (uint64);
}
