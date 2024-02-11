// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/utils/interfaces/IMulticall.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IMulticall {
    function multicall(bytes[] calldata data)
        external
        returns (bytes[] memory results);
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-API3/airnode-991af4d69e82c1954a5c6c8e247cde8eb76101de/packages/airnode-protocol-v1/contracts/utils/interfaces/IExtendedMulticall.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

interface IExtendedMulticall is IMulticall {
    function getChainId() external view returns (uint256);

    function getBalance(address account) external view returns (uint256);

    function getBlockNumber() external view returns (uint256);

    function getBlockTimestamp() external view returns (uint256);

    function getBlockBasefee() external view returns (uint256);
}
