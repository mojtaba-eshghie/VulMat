// File: ../sc_datasets/DAppSCAN/PeckShield-Rikkei/rifi-protocol-b33243fb3a218cc195f0727fe1499cb57f5ea0b2/tests/Contracts/Const.sol

pragma solidity ^0.5.16;

contract ConstBase {
    uint public constant C = 1;

    function c() public pure returns (uint) {
        return 1;
    }

    function ADD(uint a) public view returns (uint) {
        // tells compiler to accept view instead of pure
        if (false) {
            C + now;
        }
        return a + C;
    }

    function add(uint a) public view returns (uint) {
        // tells compiler to accept view instead of pure
        if (false) {
            C + now;
        }
        return a + c();
    }
}

contract ConstSub is ConstBase {
    function c() public pure returns (uint) {
        return 2;
    }
}
