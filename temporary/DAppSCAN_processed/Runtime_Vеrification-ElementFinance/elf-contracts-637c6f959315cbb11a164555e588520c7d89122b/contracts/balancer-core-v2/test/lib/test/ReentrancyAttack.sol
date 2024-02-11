// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-ElementFinance/elf-contracts-637c6f959315cbb11a164555e588520c7d89122b/contracts/balancer-core-v2/test/lib/test/ReentrancyAttack.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

contract ReentrancyAttack {
    function callSender(bytes4 data) public {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, ) = msg.sender.call(abi.encodeWithSelector(data));
        require(success, "REENTRANCY_ATTACK");
    }
}
