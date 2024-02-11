// File: ../sc_datasets/DAppSCAN/PeckShield-Kalmar/leverage-yield-contracts-ad08aef5a2281639a3226f31d4d8d5aaba73967e/contracts/weth/IWETH.sol

pragma solidity >=0.5.0;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint256 value) external returns (bool);
    function withdraw(uint256) external;
}
