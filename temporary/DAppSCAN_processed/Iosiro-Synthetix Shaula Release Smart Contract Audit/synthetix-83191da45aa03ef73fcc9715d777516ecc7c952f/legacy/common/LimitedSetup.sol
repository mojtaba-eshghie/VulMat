// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-83191da45aa03ef73fcc9715d777516ecc7c952f/legacy/common/LimitedSetup.sol

pragma solidity 0.4.25;


// https://docs.synthetix.io/contracts/LimitedSetup
contract LimitedSetup {
    uint setupExpiryTime;

    /**
     * @dev LimitedSetup Constructor.
     * @param setupDuration The time the setup period will last for.
     */
    constructor(uint setupDuration) public {
        setupExpiryTime = now + setupDuration;
    }

    modifier onlyDuringSetup {
        require(now < setupExpiryTime, "Can only perform this action during setup");
        _;
    }
}
