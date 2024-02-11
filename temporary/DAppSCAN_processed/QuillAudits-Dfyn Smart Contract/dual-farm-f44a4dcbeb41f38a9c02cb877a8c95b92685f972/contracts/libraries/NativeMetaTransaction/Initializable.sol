// File: ../sc_datasets/DAppSCAN/QuillAudits-Dfyn Smart Contract/dual-farm-f44a4dcbeb41f38a9c02cb877a8c95b92685f972/contracts/libraries/NativeMetaTransaction/Initializable.sol

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.11;

contract Initializable {
    bool inited = false;

    modifier initializer() {
        require(!inited, 'already inited');
        _;
        inited = true;
    }
}
