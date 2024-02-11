// File: ../sc_datasets/DAppSCAN/QuillAudits-C.R.E.A.M. Finance-Flashloan/compound-protocol-e414160eb8a774140457c885bb099baae528df04/tests/Contracts/MathHelpers.sol

pragma solidity ^0.5.16;

contract MathHelpers {

    /*
     * @dev Creates a number like 15e16 as a uint256 from scientific(15, 16).
     */
    function scientific(uint val, uint expTen) pure internal returns (uint) {
        return val * ( 10 ** expTen );
    }

}
