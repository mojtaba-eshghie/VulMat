// File: ../sc_datasets/DAppSCAN/PeckShield-ShibaNova/Contracts-b6b1ce1fcaff83d360df8944309f49958842b7b8/shibanova/contracts/interfaces/IMoneyPot.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface IMoneyPot {
    function isDividendsToken(address _tokenAddr) external view returns (bool);
    function getRegisteredTokenLength() external view returns (uint256);
    function depositRewards(address _token, uint256 _amount) external;
    function getRegisteredToken(uint256 index) external view returns (address);
    function updateSNovaHolder(address _sNovaHolder) external;
}
