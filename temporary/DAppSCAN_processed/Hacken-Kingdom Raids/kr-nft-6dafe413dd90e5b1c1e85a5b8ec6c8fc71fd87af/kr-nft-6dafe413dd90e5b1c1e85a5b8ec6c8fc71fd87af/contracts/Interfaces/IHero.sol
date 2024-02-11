// File: ../sc_datasets/DAppSCAN/Hacken-Kingdom Raids/kr-nft-6dafe413dd90e5b1c1e85a5b8ec6c8fc71fd87af/kr-nft-6dafe413dd90e5b1c1e85a5b8ec6c8fc71fd87af/contracts/Interfaces/IHero.sol

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface IHero {
    function mintWithSummon(address _to) external returns (uint256);
    function mint(address to) external returns (uint256);
}
