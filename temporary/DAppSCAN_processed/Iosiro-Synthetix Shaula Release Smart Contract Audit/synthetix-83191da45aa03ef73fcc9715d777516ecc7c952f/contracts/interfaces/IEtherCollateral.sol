// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-83191da45aa03ef73fcc9715d777516ecc7c952f/contracts/interfaces/IEtherCollateral.sol

pragma solidity >=0.4.24;


// https://docs.synthetix.io/contracts/source/interfaces/iethercollateral
interface IEtherCollateral {
    // Views
    function totalIssuedSynths() external view returns (uint256);

    function totalLoansCreated() external view returns (uint256);

    function totalOpenLoanCount() external view returns (uint256);

    // Mutative functions
    function openLoan() external payable returns (uint256 loanID);

    function closeLoan(uint256 loanID) external;

    function liquidateUnclosedLoan(address _loanCreatorsAddress, uint256 _loanID) external;
}
