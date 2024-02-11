// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether/pool-contracts-956b9e9dfd41dacd4040c08b5061354cc11897fc/contracts/utils/UInt256Array.sol

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.7.0;

library UInt256Array {
  function remove(uint256[] storage self, uint256 index) internal {
    require(index < self.length, "UInt256Array/unknown-index");
    self[index] = self[self.length-1];
    delete self[self.length-1];
    self.pop();
  }
}

// File: ../sc_datasets/DAppSCAN/consensys-PoolTogether/pool-contracts-956b9e9dfd41dacd4040c08b5061354cc11897fc/contracts/test/UInt256ArrayExposed.sol

pragma solidity >=0.6.0 <0.7.0;

contract UInt256ArrayExposed {
  using UInt256Array for uint256[];

  uint256[] internal array;

  constructor (uint256[] memory _array) public {
    array = new uint256[](_array.length);
    for (uint256 i = 0; i < _array.length; i++) {
      array[i] = _array[i];
    }
  }

  function remove(uint256 index) external {
    array.remove(index);
  }

  function toArray() external view returns (uint256[] memory) {
    return array;
  }
}
