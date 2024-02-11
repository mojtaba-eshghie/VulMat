// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-f141ab9cb6a5bdc66f9334a6479c5dcdd12cde2e/contracts/interfaces/ICollateralEth.sol

pragma solidity >=0.4.24;

interface ICollateralEth {
    function open(uint amount, bytes32 currency) external payable;

    function close(uint id) external;

    function deposit(address borrower, uint id) external payable;

    function withdraw(uint id, uint amount) external;

    function repay(
        address borrower,
        uint id,
        uint amount
    ) external;

    function liquidate(
        address borrower,
        uint id,
        uint amount
    ) external;

    function claim(uint amount) external;
}
