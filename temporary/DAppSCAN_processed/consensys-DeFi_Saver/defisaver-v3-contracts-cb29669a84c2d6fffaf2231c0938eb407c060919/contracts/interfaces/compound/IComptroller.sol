// File: ../sc_datasets/DAppSCAN/consensys-DeFi_Saver/defisaver-v3-contracts-cb29669a84c2d6fffaf2231c0938eb407c060919/contracts/interfaces/compound/IComptroller.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

abstract contract IComptroller {
    struct CompMarketState {
        uint224 index;
        uint32 block;
    }

    function claimComp(address holder) public virtual;
    function claimComp(address holder, address[] memory cTokens) public virtual;
    function claimComp(address[] memory holders, address[] memory cTokens, bool borrowers, bool suppliers) public virtual;

    function compSupplyState(address) public view virtual returns (CompMarketState memory);
    function compSupplierIndex(address,address) public view virtual returns (uint);
    function compAccrued(address) public view virtual returns (uint);

    function compBorrowState(address) public view virtual returns (CompMarketState memory);
    function compBorrowerIndex(address,address) public view virtual returns (uint);

    function enterMarkets(address[] calldata cTokens) external virtual returns (uint256[] memory);

    function exitMarket(address cToken) external virtual returns (uint256);

    function getAssetsIn(address account) external virtual view returns (address[] memory);

    function markets(address account) public virtual view returns (bool, uint256);

    function getAccountLiquidity(address account) external virtual view returns (uint256, uint256, uint256);

    function oracle() public virtual view returns (address);
}
