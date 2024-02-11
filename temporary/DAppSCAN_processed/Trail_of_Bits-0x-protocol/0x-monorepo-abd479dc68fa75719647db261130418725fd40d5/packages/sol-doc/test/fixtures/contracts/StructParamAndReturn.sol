// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-0x-protocol/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/packages/sol-doc/test/fixtures/contracts/StructParamAndReturn.sol

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
