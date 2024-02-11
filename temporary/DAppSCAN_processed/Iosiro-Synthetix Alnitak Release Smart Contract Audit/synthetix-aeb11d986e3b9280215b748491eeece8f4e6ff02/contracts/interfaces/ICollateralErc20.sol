// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-aeb11d986e3b9280215b748491eeece8f4e6ff02/contracts/interfaces/ICollateralErc20.sol

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
