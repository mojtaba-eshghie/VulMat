// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project1/openzeppelin-contracts-2.0.1/contracts/math/Math.sol

pragma solidity ^0.4.24;

/**
 * @title Math
 * @dev Assorted math operations
 */
library Math {
  /**
  * @dev Returns the largest of two numbers.
  */
  function max(uint256 a, uint256 b) internal pure returns (uint256) {
    return a >= b ? a : b;
  }

  /**
  * @dev Returns the smallest of two numbers.
  */
  function min(uint256 a, uint256 b) internal pure returns (uint256) {
    return a < b ? a : b;
  }

  /**
  * @dev Calculates the average of two numbers. Since these are integers,
  * averages of an even and odd number cannot be represented, and will be
  * rounded down.
  */
  function average(uint256 a, uint256 b) internal pure returns (uint256) {
    // (a + b) / 2 can overflow, so we distribute
    return (a / 2) + (b / 2) + ((a % 2 + b % 2) / 2);
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project1/openzeppelin-contracts-2.0.1/contracts/utils/Arrays.sol

pragma solidity ^0.4.23;

/**
 * @title Arrays
 * @dev Utility library of inline array functions
 */
library Arrays {

  /**
   * @dev Upper bound search function which is kind of binary search algoritm. It searches sorted
   * array to find index of the element value. If element is found then returns it's index otherwise
   * it returns index of first element which is grater than searched value. If searched element is
   * bigger than any array element function then returns first index after last element (i.e. all
   * values inside the array are smaller than the target). Complexity O(log n).
   * @param array The array sorted in ascending order.
   * @param element The element's value to be find.
   * @return The calculated index value. Returns 0 for empty array.
   */
  function findUpperBound(
    uint256[] storage array,
    uint256 element
  ) 
    internal
    view
    returns (uint256)
  {
    if (array.length == 0) {
      return 0;
    }
    
    uint256 low = 0;
    uint256 high = array.length;

    while (low < high) {
      uint256 mid = Math.average(low, high);

      // Note that mid will always be strictly less than high (i.e. it will be a valid array index) 
      // because Math.average rounds down (it does integer division with truncation).
      if (array[mid] > element) {
        high = mid;
      } else {
        low = mid + 1;
      }
    }

    // At this point `low` is the exclusive upper bound. We will return the inclusive upper bound.
    if (low > 0 && array[low - 1] == element) {
      return low - 1;
    } else {
      return low;
    }
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project1/openzeppelin-contracts-2.0.1/contracts/mocks/ArraysImpl.sol

pragma solidity ^0.4.24;

contract ArraysImpl {

  using Arrays for uint256[];

  uint256[] private array;

  constructor(uint256[] _array) public {
    array = _array;
  }

  function findUpperBound(uint256 _element) external view returns (uint256) {
    return array.findUpperBound(_element);
  }
}
