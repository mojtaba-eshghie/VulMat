// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-OriginDollar/origin-dollar-81431fd3b2aa4c518ffc389844f9708c00b516f0/contracts/contracts/strategies/ICurveGauge.sol

pragma solidity 0.5.11;

interface ICurveGauge {
    function balanceOf(address account) external view returns (uint256);

    function deposit(uint256 value, address account) external;

    function withdraw(uint256 value) external;
}
