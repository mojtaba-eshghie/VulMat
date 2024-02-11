// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-ElementFinance/elf-contracts-b9ab6095a211ccb81941a5104c581e3564a97502/contracts/balancer-core-v2/test/lib/ReentrancyAttack.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

contract ReentrancyAttack {
    function callSender(bytes4 data) public {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, ) = msg.sender.call(abi.encodeWithSelector(data));
        require(success, "REENTRANCY_ATTACK");
    }
}
