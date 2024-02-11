// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Utils/BlockMiner.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;
// file: BlockMinder.sol

// used to "waste" blocks for truffle tests
contract BlockMiner {
    uint256 public blocksMined;

    constructor () public {
        blocksMined = 0;
    }

    function mine() public {
       blocksMined += 1;
    }

    function blockTime() external view returns (uint256) {
       return block.timestamp;
    }
}
