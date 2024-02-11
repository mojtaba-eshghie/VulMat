// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-aztec/AZTEC-c3f49df54849cd2e91a9ba4937d895179e7c283d/packages/protocol/contracts/libs/SafeMath8.sol

pragma solidity >=0.5.0 <= 0.6.0;

/**
 * @title Library of SafeMath arithmetic operations
 * @author AZTEC
 * Copyright Spilsbury Holdings Ltd 2019. All rights reserved.
 **/

library SafeMath8 {
    
    /**
    * @dev SafeMath multiplication
    * @param a - uint8 multiplier
    * @param b - uint8 multiplicand
    * @return uint8 result of multiplying a and b
    */
    function mul(uint8 a, uint8 b) internal pure returns (uint8) {
        uint256 c = uint256(a) * uint256(b);
        require(c < 256, "uint8 mul triggered integer overflow");
        return uint8(c);
    }

    /**
    * @dev SafeMath division
    * @param a - uint8 dividend
    * @param b - uint8 divisor
    * @return uint8 result of dividing a by b
    */
    function div(uint8 a, uint8 b) internal pure returns (uint8) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        // assert(a == b * c + a % b); // There is no case in which this doesn’t hold
        return a / b;
    }

    /**
    * @dev SafeMath subtraction
    * @param a - uint8 minuend
    * @param b - uint8 subtrahend
    * @return uint8 result of subtracting b from a
    */
    function sub(uint8 a, uint8 b) internal pure returns (uint8) {
        require(b <= a, "uint8 sub triggered integer underflow");
        return a - b;
    }

    /**
    * @dev SafeMath addition
    * @param a - uint8 addend
    * @param b - uint8 addend
    * @return uint8 result of adding a and b
    */
    function add(uint8 a, uint8 b) internal pure returns (uint8) {
        uint8 c = a + b;
        require(c >= a, "uint8 add triggered integer overflow");
        return c;
    }
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-aztec/AZTEC-c3f49df54849cd2e91a9ba4937d895179e7c283d/packages/protocol/contracts/test/libs/SafeMath8Test.sol

pragma solidity >=0.5.0 <0.6.0;

contract SafeMath8Test {
    using SafeMath8 for uint8;

    function _mul(uint8 a, uint8 b) public pure returns (uint8) {
        return(a.mul(b));
    }

    function _add(uint8 a, uint8 b) public pure returns (uint8) {
        return(a.add(b));
    }

    function _sub(uint8 a, uint8 b) public pure returns (uint8) {
        return(a.sub(b));
    }
}
