// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-OriginDollar/origin-dollar-81431fd3b2aa4c518ffc389844f9708c00b516f0/contracts/contracts/interfaces/IMinMaxOracle.sol

pragma solidity 0.5.11;

interface IMinMaxOracle {
    //Assuming 8 decimals
    function priceMin(string calldata symbol) external returns (uint256);

    function priceMax(string calldata symbol) external returns (uint256);
}

interface IViewMinMaxOracle {
    function priceMin(string calldata symbol) external view returns (uint256);

    function priceMax(string calldata symbol) external view returns (uint256);
}
