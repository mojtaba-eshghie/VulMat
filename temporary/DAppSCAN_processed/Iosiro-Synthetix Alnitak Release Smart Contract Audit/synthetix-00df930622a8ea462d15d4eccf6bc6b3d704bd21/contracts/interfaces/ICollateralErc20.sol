// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-00df930622a8ea462d15d4eccf6bc6b3d704bd21/contracts/interfaces/ICollateralErc20.sol

pragma solidity >=0.4.24;

interface ICollateralErc20 {
    function open(
        uint collateral,
        uint amount,
        bytes32 currency
    ) external;

    function close(uint id) external;

    function deposit(
        address borrower,
        uint id,
        uint collateral
    ) external;

    function withdraw(uint id, uint amount) external;

    function repay(
        address borrower,
        uint id,
        uint amount
    ) external;

    function draw(uint id, uint amount) external;

    function liquidate(
        address borrower,
        uint id,
        uint amount
    ) external;
}
