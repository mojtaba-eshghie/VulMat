// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-82cc39e4a005576e00c9684e6f69fe0f8b623811/contracts/interfaces/ISupplySchedule.sol

pragma solidity >=0.4.24;


// https://docs.synthetix.io/contracts/source/interfaces/isupplyschedule
interface ISupplySchedule {
    // Views
    function mintableSupply() external view returns (uint);

    function isMintable() external view returns (bool);

    // Mutative functions
    function recordMintEvent(uint supplyMinted) external returns (bool);
}
