// File: ../sc_datasets/DAppSCAN/Quantstamp-Backstop Syndicate for MakerDAO/dai-backstop-syndicate-965a3dbd44e42705ac4aa38e37e21949032f2fc8/contracts/syndicate/EnumerableSet.sol

pragma solidity 0.5.16;


/**
 * Adapted from OpenZeppelin's address version of the same, written by Alberto Cuesta Cañada:
 * https://github.com/OpenZeppelin/openzeppelin-contracts/blob/5dfe7215a9156465d550030eadc08770503b2b2f/
 *   contracts/utils/EnumerableSet.sol
 */
library EnumerableSet {

  struct AuctionIDSet {
    // Position of the value in the `values` array, plus 1 because index 0
    // means a value is not in the set.
    mapping (uint256 => uint256) index;
    uint256[] values;
  }

  /**
   * @dev Add a value to a set. O(1).
   * Returns false if the value was already in the set.
   */
  function add(AuctionIDSet storage set, uint256 value)
    internal
    returns (bool)
  {
    if (!contains(set, value)) {
      set.values.push(value);
      // The element is stored at length-1, but we add 1 to all indexes
      // and use 0 as a sentinel value
      set.index[value] = set.values.length;
      return true;
    } else {
      return false;
    }
  }

  /**
   * @dev Removes a value from a set. O(1).
   * Returns false if the value was not present in the set.
   */
  function remove(AuctionIDSet storage set, uint256 value)
    internal
    returns (bool)
  {
    if (contains(set, value)){
      uint256 toDeleteIndex = set.index[value] - 1;
      uint256 lastIndex = set.values.length - 1;

      // If the element we're deleting is the last one, we can just remove it without doing a swap
      if (lastIndex != toDeleteIndex) {
        uint256 lastValue = set.values[lastIndex];

        // Move the last value to the index where the deleted value is
        set.values[toDeleteIndex] = lastValue;
        // Update the index for the moved value
        set.index[lastValue] = toDeleteIndex + 1; // All indexes are 1-based
      }

      // Delete the index entry for the deleted value
      delete set.index[value];

      // Delete the old entry for the moved value
      set.values.pop();

      return true;
    } else {
      return false;
    }
  }

  /**
   * @dev Returns true if the value is in the set. O(1).
   */
  function contains(AuctionIDSet storage set, uint256 value)
    internal
    view
    returns (bool)
  {
    return set.index[value] != 0;
  }

  /**
   * @dev Returns an array with all values in the set. O(N).
   * Note that there are no guarantees on the ordering of values inside the
   * array, and it may change when more values are added or removed.
   * WARNING: This function may run out of gas on large sets: use {length} and
   * {get} instead in these cases.
   */
  function enumerate(AuctionIDSet storage set)
    internal
    view
    returns (uint256[] memory)
  {
    uint256[] memory output = new uint256[](set.values.length);
    for (uint256 i; i < set.values.length; i++){
      output[i] = set.values[i];
    }
    return output;
  }

  /**
   * @dev Returns the number of elements on the set. O(1).
   */
  function length(AuctionIDSet storage set)
    internal
    view
    returns (uint256)
  {
    return set.values.length;
  }

   /** @dev Returns the element stored at position `index` in the set. O(1).
  * Note that there are no guarantees on the ordering of values inside the
  * array, and it may change when more values are added or removed.
  *
  * Requirements:
  *
  * - `index` must be strictly less than {length}.
  */
  function get(AuctionIDSet storage set, uint256 index)
    internal
    view
    returns (uint256)
  {
    return set.values[index];
  }
}
