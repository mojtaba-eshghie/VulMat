// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-82cc39e4a005576e00c9684e6f69fe0f8b623811/contracts/interfaces/ICollateralManager.sol

pragma solidity >=0.4.24;

interface ICollateralManager {
    function collateralByAddress(address collateral) external view returns (bool);

    function long(bytes32 synth) external view returns (uint amount);
    
    function short(bytes32 synth) external view returns (uint amount);

    function totalLong() external view returns (uint debt);

    function getScaledUtilisation() external view returns (uint scaledUtilisation);

    function addCollateral(address collateral) external;

    function addSynth(address synth) external;
    
    function incrementLongs(bytes32 synth, uint amount) external;

    function decrementLongs(bytes32 synth, uint amount) external;

    function incrementShorts(bytes32 synth, uint amount) external; 

    function decrementShorts(bytes32 synth, uint amount) external; 
}
