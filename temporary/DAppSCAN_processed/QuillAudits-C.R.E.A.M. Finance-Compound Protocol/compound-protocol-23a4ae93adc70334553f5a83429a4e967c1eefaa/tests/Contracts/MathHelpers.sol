// File: ../sc_datasets/DAppSCAN/QuillAudits-C.R.E.A.M. Finance-Compound Protocol/compound-protocol-23a4ae93adc70334553f5a83429a4e967c1eefaa/tests/Contracts/MathHelpers.sol

pragma solidity ^0.5.16;

contract MathHelpers {

    /*
     * @dev Creates a number like 15e16 as a uint256 from scientific(15, 16).
     */
    function scientific(uint val, uint expTen) pure internal returns (uint) {
        return val * ( 10 ** expTen );
    }

}
