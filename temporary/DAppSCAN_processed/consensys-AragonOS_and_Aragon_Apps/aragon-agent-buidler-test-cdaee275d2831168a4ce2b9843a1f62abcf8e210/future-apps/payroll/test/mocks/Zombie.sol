// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragon-agent-buidler-test-cdaee275d2831168a4ce2b9843a1f62abcf8e210/future-apps/payroll/test/mocks/Zombie.sol

pragma solidity 0.4.18;


contract Zombie {
    address public owner;

    function Zombie(address _owner) public {
        owner = _owner;
    }

    function() public payable {}

    function escapeHatch() public {
        selfdestruct(owner);
    }

}
