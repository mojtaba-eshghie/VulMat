// File: ../sc_datasets/DAppSCAN/consensys-AragonBlack_Fundraising/fundraising-5ad1332955bab9d36cfad345ae92b7ad7dc0bdbe/shared/interfaces/contracts/IAragonFundraisingController.sol

pragma solidity 0.4.24;


contract IAragonFundraisingController {
    function openTrading() external;
    function collateralsToBeClaimed(address _collateral) public view returns (uint256);
    function balanceOf(address _who, address _token) public view returns (uint256);
}
