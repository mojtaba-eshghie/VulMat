// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-0x v3 Staking/0x-monorepo-b8e01d7be535196a3145a431291183ecfbb333c6/packages/sol-doc/test/fixtures/contracts/StructParamAndReturn.sol

pragma solidity 0.4.24;
pragma experimental ABIEncoderV2;


contract StructParamAndReturn {

    struct Stuff {
        address anAddress;       
        uint256 aNumber;    
    }

    /// @dev DEV_COMMENT
    /// @param stuff STUFF_COMMENT
    /// @return RETURN_COMMENT
    function methodWithStructParamAndReturn(Stuff stuff) public pure returns(Stuff) {
        return stuff;
    }
}
