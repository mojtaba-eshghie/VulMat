// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-eb36644a2d8db32c92cc4df936069db8836d0233/contracts/interfaces/ICollateralErc20.sol

pragma solidity >=0.4.24;

interface ICollateralErc20 {
    function open(uint collateral, uint amount, bytes32 currency) external;

    function close(uint id) external;

    function deposit(address borrower, uint id, uint collateral) external;

    function withdraw(uint id, uint amount) external;

    function repay(address borrower, uint id, uint amount) external;

    function draw(uint id, uint amount) external;

    function liquidate(address borrower, uint id, uint amount) external;
}
