// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-aztec/AZTEC-c3f49df54849cd2e91a9ba4937d895179e7c283d/packages/protocol/contracts/test/ACE/BehaviourWithConflictTest.sol

pragma solidity ^0.5.0;

contract BehaviourWithConflictTest {
    event ReachedBehaviour();

    /**
        * @return The address of the proxy admin.
    */
    function admin() external returns (address) {
        emit ReachedBehaviour();
        return address(0x0);
    }
}
