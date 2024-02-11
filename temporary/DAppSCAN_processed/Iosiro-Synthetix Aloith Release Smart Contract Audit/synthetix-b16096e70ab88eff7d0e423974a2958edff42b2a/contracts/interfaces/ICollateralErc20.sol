// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Aloith Release Smart Contract Audit/synthetix-b16096e70ab88eff7d0e423974a2958edff42b2a/contracts/interfaces/ICollateralErc20.sol

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
