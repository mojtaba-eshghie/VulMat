// File: ../sc_datasets/DAppSCAN/PepperSec-POA-Network-Wizard/core-cebb1089c417a8e26bd97a44f7234bdb9d0bd781/test/mock/application/functions/init/ApplicationMockNonDefaultInit.sol

pragma solidity ^0.4.21;


library ApplicationMockNonDefaultInit {

    function init(bytes) public pure {}

    function initSel() public pure returns (bytes4) {
        return bytes4(keccak256("init(bytes)"));
    }
}
