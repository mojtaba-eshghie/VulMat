// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-LiquityProtocolandStabilityPoolFinalReport/dev-8cec3fda04b8c71994dc14858386bf6a161164fc/packages/contracts/contracts/Interfaces/ICommunityIssuance.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.11;

interface ICommunityIssuance { 
    
    // --- Events ---
    
    event LQTYTokenAddressSet(address _lqtyTokenAddress);
    
    event StabilityPoolAddressSet(address _stabilityPoolAddress);

    // --- Functions ---

    function setAddresses(address _lqtyTokenAddress, address _stabilityPoolAddress) external;

    function issueLQTY() external returns (uint);

    function sendLQTY(address _account, uint _LQTYamount) external;
}
