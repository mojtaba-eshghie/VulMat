// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-aztec/AZTEC-c3f49df54849cd2e91a9ba4937d895179e7c283d/packages/protocol/contracts/interfaces/JoinSplitInterface.sol

pragma solidity >=0.5.0 <0.6.0;

/**
 * @title JoinSplitInterface
 * @author AZTEC
 * @dev An interface defining the JoinSplitInterface standard.
 * Copyright Spilsbury Holdings Ltd 2019. All rights reserved.
 **/
interface JoinSplitInterface {
    /* solhint-disable-next-line var-name-mixedcase */
    
    function validateJoinSplit(
        bytes calldata, 
        address, 
        uint[6] calldata
    ) external pure returns (bytes memory);
}
