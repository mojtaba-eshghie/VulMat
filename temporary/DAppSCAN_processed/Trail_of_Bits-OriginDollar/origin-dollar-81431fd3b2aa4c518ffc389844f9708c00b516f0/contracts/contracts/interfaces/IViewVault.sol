// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-OriginDollar/origin-dollar-81431fd3b2aa4c518ffc389844f9708c00b516f0/contracts/contracts/interfaces/IViewVault.sol

pragma solidity 0.5.11;

contract IViewVault {
    function getAllAssets() public view returns (address[] memory);

    function totalValue() public view returns (uint256 value);

    function priceUSDMint(string calldata symbol)
        external
        view
        returns (uint256);

    function priceUSDRedeem(string calldata symbol)
        external
        view
        returns (uint256);

    function calculateRedeemOutputs(uint256 _amount)
        external
        view
        returns (uint256[] memory);
}
