// File: ../sc_datasets/DAppSCAN/consensys-Rocketpool/rocketpool-2.5-Tokenomics-updates/contracts/interface/RocketVaultInterface.sol

pragma solidity 0.7.6;

// SPDX-License-Identifier: GPL-3.0-only

interface RocketVaultInterface {
    function balanceOf(string memory _networkContractName) external view returns (uint256);
    function depositEther() external payable;
    function withdrawEther(uint256 _amount) external;
    function depositToken(string memory _networkContractName, address _tokenAddress, uint256 _amount) external returns (bool);
    function withdrawToken(address _withdrawalAddress, address _tokenAddress, uint256 _amount) external returns (bool);
    function balanceOfToken(string memory _networkContractName, address _tokenAddress) external view returns (uint256);
    function transferToken(string memory _networkContractName, address _tokenAddress, uint256 _amount) external returns (bool);
}
