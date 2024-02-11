// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-AZTEC Protocol/AZTEC-7a020f4ced9680f6e4a452fe570671aac0802471/packages/protocol/contracts/interfaces/BilateralSwapInterface.sol

pragma solidity >=0.5.0 <0.6.0;

contract BilateralSwapInterface {    
    function validateBilateralSwap(
        bytes calldata, 
        address, 
        uint[6] calldata
    ) 
        external 
        pure 
        returns (bytes memory) 
    {}
}
