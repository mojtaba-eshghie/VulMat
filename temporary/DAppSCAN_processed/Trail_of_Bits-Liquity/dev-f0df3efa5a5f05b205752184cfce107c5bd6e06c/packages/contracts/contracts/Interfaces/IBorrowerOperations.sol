// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-Liquity/dev-f0df3efa5a5f05b205752184cfce107c5bd6e06c/packages/contracts/contracts/Interfaces/IBorrowerOperations.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

// Common interface for the Trove Manager.
interface IBorrowerOperations {

    // --- Events ---

    event TroveManagerAddressChanged(address _newTroveManagerAddress);

    event ActivePoolAddressChanged(address _activePoolAddress);

    event DefaultPoolAddressChanged(address _defaultPoolAddress);

    event StabilityPoolAddressChanged(address _stabilityPoolAddress);

    event CollSurplusPoolAddressChanged(address _collSurplusPoolAddress);

    event PriceFeedAddressChanged(address  _newPriceFeedAddress);

    event SortedTrovesAddressChanged(address _sortedTrovesAddress);

    event LUSDTokenAddressChanged(address _lusdTokenAddress);

    event LQTYStakingAddressChanged(address _lqtyStakingAddress);

    event RedeemedCollateralClaimed(address indexed _user);

    // --- Functions ---

    function setAddresses(
        address _troveManagerAddress,
        address _activePoolAddress,
        address _defaultPoolAddress,
        address _stabilityPoolAddress,
        address _collSurplusPoolAddress,
        address _priceFeedAddress,
        address _sortedTrovesAddress,
        address _lusdTokenAddress,
        address _lqtyStakingAddress
    ) external;

    function openTrove(uint _LUSDAmount, address _hint) external payable;

    function addColl(address _hint) external payable;

    function moveETHGainToTrove(address _user, address _hint) external payable;

    function withdrawColl(uint _amount, address _hint) external;

    function withdrawLUSD(uint _amount, address _hint) external;

    function repayLUSD(uint _amount, address _hint) external;

    function closeTrove() external;

    function adjustTrove(uint _collWithdrawal, uint _debtChange, bool isDebtIncrease, address _hint) external payable;

    function claimRedeemedCollateral(address _user) external;

    function getCompositeDebt(uint _debt) external pure returns (uint);
}
