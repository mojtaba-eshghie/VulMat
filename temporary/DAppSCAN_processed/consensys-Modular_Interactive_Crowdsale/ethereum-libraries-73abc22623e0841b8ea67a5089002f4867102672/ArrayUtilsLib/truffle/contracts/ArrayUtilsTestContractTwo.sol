// File: ../sc_datasets/DAppSCAN/consensys-Modular_Interactive_Crowdsale/ethereum-libraries-73abc22623e0841b8ea67a5089002f4867102672/ArrayUtilsLib/truffle/contracts/Array256Lib.sol

pragma solidity ^0.4.18;

/**
 * @title Array256 Library
 * @author Majoolr.io
 *
 * version 1.1.0
 * Copyright (c) 2017 Majoolr, LLC
 * The MIT License (MIT)
 * https://github.com/Majoolr/ethereum-libraries/blob/master/LICENSE
 *
 * The Array256 Library provides a few utility functions to work with
 * storage uint256[] types in place. Majoolr provides smart contract services
 * and security reviews for contract deployments in addition to working on open
 * source projects in the Ethereum community. Our purpose is to test, document,
 * and deploy reusable code onto the blockchain and improve both security and
 * usability. We also educate non-profits, schools, and other community members
 * about the application of blockchain technology.
 * For further information: majoolr.io
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

library Array256Lib {

  /// @dev Sum vector
  /// @param self Storage array containing uint256 type variables
  /// @return sum The sum of all elements, does not check for overflow
  function sumElements(uint256[] storage self) public view returns(uint256 sum) {
    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        sum := add(sload(add(sha3(0x60,0x20),i)),sum)
      }
    }
  }

  /// @dev Returns the max value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return maxValue The highest value in the array
  function getMax(uint256[] storage self) public view returns(uint256 maxValue) {
    assembly {
      mstore(0x60,self_slot)
      maxValue := sload(sha3(0x60,0x20))

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        switch gt(sload(add(sha3(0x60,0x20),i)), maxValue)
        case 1 {
          maxValue := sload(add(sha3(0x60,0x20),i))
        }
      }
    }
  }

  /// @dev Returns the minimum value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return minValue The highest value in the array
  function getMin(uint256[] storage self) public view returns(uint256 minValue) {
    assembly {
      mstore(0x60,self_slot)
      minValue := sload(sha3(0x60,0x20))

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        switch gt(sload(add(sha3(0x60,0x20),i)), minValue)
        case 0 {
          minValue := sload(add(sha3(0x60,0x20),i))
        }
      }
    }
  }

  /// @dev Finds the index of a given value in an array
  /// @param self Storage array containing uint256 type variables
  /// @param value The value to search for
  /// @param isSorted True if the array is sorted, false otherwise
  /// @return found True if the value was found, false otherwise
  /// @return index The index of the given value, returns 0 if found is false
  function indexOf(uint256[] storage self, uint256 value, bool isSorted)
           public
           view
           returns(bool found, uint256 index) {
    assembly{
      mstore(0x60,self_slot)
      switch isSorted
      case 1 {
        let high := sub(sload(self_slot),1)
        let mid := 0
        let low := 0
        for { } iszero(gt(low, high)) { } {
          mid := div(add(low,high),2)

          switch lt(sload(add(sha3(0x60,0x20),mid)),value)
          case 1 {
             low := add(mid,1)
          }
          case 0 {
            switch gt(sload(add(sha3(0x60,0x20),mid)),value)
            case 1 {
              high := sub(mid,1)
            }
            case 0 {
              found := 1
              index := mid
              low := add(high,1)
            }
          }
        }
      }
      case 0 {
        for { let low := 0 } lt(low, sload(self_slot)) { low := add(low, 1) } {
          switch eq(sload(add(sha3(0x60,0x20),low)), value)
          case 1 {
            found := 1
            index := low
            low := sload(self_slot)
          }
        }
      }
    }
  }

  /// @dev Utility function for heapSort
  /// @param index The index of child node
  /// @return pI The parent node index
  function getParentI(uint256 index) private pure returns (uint256 pI) {
    uint256 i = index - 1;
    pI = i/2;
  }

  /// @dev Utility function for heapSort
  /// @param index The index of parent node
  /// @return lcI The index of left child
  function getLeftChildI(uint256 index) private pure returns (uint256 lcI) {
    uint256 i = index * 2;
    lcI = i + 1;
  }

  /// @dev Sorts given array in place
  /// @param self Storage array containing uint256 type variables
  function heapSort(uint256[] storage self) public {
    uint256 end = self.length - 1;
    uint256 start = getParentI(end);
    uint256 root = start;
    uint256 lChild;
    uint256 rChild;
    uint256 swap;
    uint256 temp;
    while(start >= 0){
      root = start;
      lChild = getLeftChildI(start);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end+1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
      if(start == 0)
        break;
      else
        start = start - 1;
    }
    while(end > 0){
      temp = self[end];
      self[end] = self[0];
      self[0] = temp;
      end = end - 1;
      root = 0;
      lChild = getLeftChildI(0);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end + 1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
    }
  }

  /// @dev Removes duplicates from a given array.
  /// @param self Storage array containing uint256 type variables
  function uniq(uint256[] storage self) public returns (uint256 length) {
    bool contains;
    uint256 index;

    for (uint256 i = 0; i < self.length; i++) {
      (contains, index) = indexOf(self, self[i], false);

      if (i > index) {
        for (uint256 j = i; j < self.length - 1; j++){
          self[j] = self[j + 1];
        }

        delete self[self.length - 1];
        self.length--;
        i--;
      }
    }

    length = self.length;
  }
}

// File: ../sc_datasets/DAppSCAN/consensys-Modular_Interactive_Crowdsale/ethereum-libraries-73abc22623e0841b8ea67a5089002f4867102672/ArrayUtilsLib/truffle/contracts/Array128Lib.sol

pragma solidity ^0.4.18;

/**
 * @title Array128 Library
 * @author Majoolr.io
 *
 * version 1.1.0
 * Copyright (c) 2017 Majoolr, LLC
 * The MIT License (MIT)
 * https://github.com/Majoolr/ethereum-libraries/blob/master/LICENSE
 *
 *  The Array128 Library provides a few utility functions to work with
 * storage uint128[] types in place. Majoolr provides smart contract services
 * and security reviews for contract deployments in addition to working on open
 * source projects in the Ethereum community. Our purpose is to test, document,
 * and deploy reusable code onto the blockchain and improve both security and
 * usability. We also educate non-profits, schools, and other community members
 * about the application of blockchain technology.
 * For further information: majoolr.io
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

library Array128Lib {

  /// @dev Sum vector
  /// @param self Storage array containing uint256 type variables
  /// @return sum The sum of all elements, does not check for overflow
  function sumElements(uint128[] storage self) public view returns(uint256 sum) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,2)))

        remainder := mod(i,2)

        for { let j := 0 } lt(j, mul(remainder, 4)) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff,term)
        sum := add(term,sum)

      }
    }
  }

  /// @dev Returns the max value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return maxValue The highest value in the array
  function getMax(uint128[] storage self) public view returns(uint128 maxValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)
      maxValue := 0

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,2)))

        remainder := mod(i,2)

        for { let j := 0 } lt(j, mul(remainder, 4)) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff,term)
        switch lt(maxValue, term)
        case 1 {
          maxValue := term
        }
      }
    }
  }

  /// @dev Returns the minimum value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return minValue The highest value in the array
  function getMin(uint128[] storage self) public view returns(uint128 minValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,2)))

        remainder := mod(i,2)

        for { let j := 0 } lt(j, mul(remainder, 4)) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff,term)
        switch eq(i,0)
        case 1 {
          minValue := term
        }
        switch gt(minValue, term)
        case 1 {
          minValue := term
        }
      }
    }
  }

  /// @dev Finds the index of a given value in an array
  /// @param self Storage array containing uint256 type variables
  /// @param value The value to search for
  /// @param isSorted True if the array is sorted, false otherwise
  /// @return found True if the value was found, false otherwise
  /// @return index The index of the given value, returns 0 if found is false
  function indexOf(uint128[] storage self, uint128 value, bool isSorted)
           public
           view
           returns(bool found, uint256 index) {
    uint256 term;
    assembly{
      mstore(0x60,self_slot)
      switch isSorted
      case 1 {
        let high := sub(sload(self_slot),1)
        let mid := 0
        let low := 0
        for { } iszero(gt(low, high)) { } {
          mid := div(add(low,high),2)
          term := sload(add(sha3(0x60,0x20),div(mid,2)))

          switch mod(mid,2)
          case 1 {
            for { let j := 0 } lt(j, 4) { j := add(j, 1) } {
              term := div(term,4294967296)
            }
          }

          term := and(term,0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff)

          switch lt(term,value)
          case 1 {
             low := add(mid,1)
          }
          case 0 {
            switch gt(term,value)
            case 1 {
              high := sub(mid,1)
            }
            case 0 {
              found := 1
              index := mid
              low := add(high,1)
            }
          }
        }
      }
      case 0 {
        for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
          term := sload(add(sha3(0x60,0x20),div(i,2)))
          switch mod(i,2)
          case 1 {
            for { let j := 0 } lt(j, 4) { j := add(j, 1) } {
              term := div(term,4294967296)
            }
          }

          term := and(term,0x00000000000000000000000000000000ffffffffffffffffffffffffffffffff)

          switch eq(term, value)
          case 1 {
            found := 1
            index := i
            i := sload(self_slot)
          }
        }
      }
    }
  }

  /// @dev Utility function for heapSort
  /// @param index The index of child node
  /// @return pI The parent node index
  function getParentI(uint256 index) private pure returns (uint256 pI) {
    uint256 i = index - 1;
    pI = i/2;
  }

  /// @dev Utility function for heapSort
  /// @param index The index of parent node
  /// @return lcI The index of left child
  function getLeftChildI(uint256 index) private pure returns (uint256 lcI) {
    uint256 i = index * 2;
    lcI = i + 1;
  }

  /// @dev Sorts given array in place
  /// @param self Storage array containing uint256 type variables
  function heapSort(uint128[] storage self) public {
    uint256 end = self.length - 1;
    uint256 start = getParentI(end);
    uint256 root = start;
    uint256 lChild;
    uint256 rChild;
    uint256 swap;
    uint128 temp;
    while(start >= 0){
      root = start;
      lChild = getLeftChildI(start);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end+1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
      if(start == 0)
        break;
      else
        start = start - 1;
    }
    while(end > 0){
      temp = self[end];
      self[end] = self[0];
      self[0] = temp;
      end = end - 1;
      root = 0;
      lChild = getLeftChildI(0);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end + 1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
    }
  }

  /// @dev Removes duplicates from a given array.
  /// @param self Storage array containing uint256 type variables
  function uniq(uint128[] storage self) public returns (uint256 length) {
    bool contains;
    uint256 index;

    for (uint256 i = 0; i < self.length; i++) {
      (contains, index) = indexOf(self, self[i], false);

      if (i > index) {
        for (uint256 j = i; j < self.length - 1; j++){
          self[j] = self[j + 1];
        }

        delete self[self.length - 1];
        self.length--;
        i--;
      }
    }

    length = self.length;
  }
}

// File: ../sc_datasets/DAppSCAN/consensys-Modular_Interactive_Crowdsale/ethereum-libraries-73abc22623e0841b8ea67a5089002f4867102672/ArrayUtilsLib/truffle/contracts/Array64Lib.sol

pragma solidity ^0.4.18;

/**
 * @title Array64 Library
 * @author Majoolr.io
 *
 * version 1.1.0
 * Copyright (c) 2017 Majoolr, LLC
 * The MIT License (MIT)
 * https://github.com/Majoolr/ethereum-libraries/blob/master/LICENSE
 *
 * The Array64 Library provides a few utility functions to work with
 * storage uint64[] types in place. Majoolr provides smart contract services
 * and security reviews for contract deployments in addition to working on open
 * source projects in the Ethereum community. Our purpose is to test, document,
 * and deploy reusable code onto the blockchain and improve both security and
 * usability. We also educate non-profits, schools, and other community members
 * about the application of blockchain technology.
 * For further information: majoolr.io
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

library Array64Lib {

  /// @dev Sum vector
  /// @param self Storage array containing uint256 type variables
  /// @return sum The sum of all elements, does not check for overflow
  function sumElements(uint64[] storage self) public view returns(uint256 sum) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,4)))

        remainder := mod(i,4)

        for { let j := 0 } lt(j, mul(remainder, 2)) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x000000000000000000000000000000000000000000000000ffffffffffffffff,term)
        sum := add(term,sum)

      }
    }
  }

  /// @dev Returns the max value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return maxValue The highest value in the array
  function getMax(uint64[] storage self) public view returns(uint64 maxValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)
      maxValue := 0

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,4)))

        remainder := mod(i,4)

        for { let j := 0 } lt(j, mul(remainder, 2)) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x000000000000000000000000000000000000000000000000ffffffffffffffff,term)
        switch lt(maxValue, term)
        case 1 {
          maxValue := term
        }
      }
    }
  }

  /// @dev Returns the minimum value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return minValue The highest value in the array
  function getMin(uint64[] storage self) public view returns(uint64 minValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,4)))

        remainder := mod(i,4)

        for { let j := 0 } lt(j, mul(remainder, 2)) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x000000000000000000000000000000000000000000000000ffffffffffffffff,term)

        switch eq(i,0)
        case 1 {
          minValue := term
        }
        switch gt(minValue, term)
        case 1 {
          minValue := term
        }
      }
    }
  }

  /// @dev Finds the index of a given value in an array
  /// @param self Storage array containing uint256 type variables
  /// @param value The value to search for
  /// @param isSorted True if the array is sorted, false otherwise
  /// @return found True if the value was found, false otherwise
  /// @return index The index of the given value, returns 0 if found is false
  function indexOf(uint64[] storage self, uint64 value, bool isSorted)
           public
           view
           returns(bool found, uint256 index) {
    if (isSorted) {
        uint256 high = self.length - 1;
        uint256 mid = 0;
        uint256 low = 0;
        while (low <= high) {
          mid = (low+high)/2;
          if (self[mid] == value) {
            found = true;
            index = mid;
            low = high + 1;
          } else if (self[mid] < value) {
            low = mid + 1;
          } else {
            high = mid - 1;
          }
        }
    } else {
      for (uint256 i = 0; i<self.length; i++) {
        if (self[i] == value) {
          found = true;
          index = i;
          i = self.length;
        }
      }
    }
  }

  /// @dev Utility function for heapSort
  /// @param index The index of child node
  /// @return pI The parent node index
  function getParentI(uint256 index) private pure returns (uint256 pI) {
    uint256 i = index - 1;
    pI = i/2;
  }

  /// @dev Utility function for heapSort
  /// @param index The index of parent node
  /// @return lcI The index of left child
  function getLeftChildI(uint256 index) private pure returns (uint256 lcI) {
    uint256 i = index * 2;
    lcI = i + 1;
  }

  /// @dev Sorts given array in place
  /// @param self Storage array containing uint256 type variables
  function heapSort(uint64[] storage self) public {
    uint256 end = self.length - 1;
    uint256 start = getParentI(end);
    uint256 root = start;
    uint256 lChild;
    uint256 rChild;
    uint256 swap;
    uint64 temp;
    while(start >= 0){
      root = start;
      lChild = getLeftChildI(start);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end+1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
      if(start == 0)
        break;
      else
        start = start - 1;
    }
    while(end > 0){
      temp = self[end];
      self[end] = self[0];
      self[0] = temp;
      end = end - 1;
      root = 0;
      lChild = getLeftChildI(0);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end + 1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
    }
  }

  /// @dev Removes duplicates from a given array.
  /// @param self Storage array containing uint256 type variables
  function uniq(uint64[] storage self) public returns (uint256 length) {
    bool contains;
    uint256 index;

    for (uint256 i = 0; i < self.length; i++) {
      (contains, index) = indexOf(self, self[i], false);

      if (i > index) {
        for (uint256 j = i; j < self.length - 1; j++){
          self[j] = self[j + 1];
        }

        delete self[self.length - 1];
        self.length--;
        i--;
      }
    }

    length = self.length;
  }
}

// File: ../sc_datasets/DAppSCAN/consensys-Modular_Interactive_Crowdsale/ethereum-libraries-73abc22623e0841b8ea67a5089002f4867102672/ArrayUtilsLib/truffle/contracts/Array32Lib.sol

pragma solidity ^0.4.18;

/**
 * @title Array32 Library
 * @author Majoolr.io
 *
 * version 1.1.0
 * Copyright (c) 2017 Majoolr, LLC
 * The MIT License (MIT)
 * https://github.com/Majoolr/ethereum-libraries/blob/master/LICENSE
 *
 * The Array32 Library provides a few utility functions to work with
 * storage uint32[] types in place. Majoolr provides smart contract services
 * and security reviews for contract deployments in addition to working on open
 * source projects in the Ethereum community. Our purpose is to test, document,
 * and deploy reusable code onto the blockchain and improve both security and
 * usability. We also educate non-profits, schools, and other community members
 * about the application of blockchain technology.
 * For further information: majoolr.io
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

library Array32Lib {

  /// @dev Sum vector
  /// @param self Storage array containing uint256 type variables
  /// @return sum The sum of all elements, does not check for overflow
  function sumElements(uint32[] storage self) public view returns(uint256 sum) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,8)))

        remainder := mod(i,8)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x00000000000000000000000000000000000000000000000000000000ffffffff,term)
        sum := add(term,sum)

      }
    }
  }

  /// @dev Returns the max value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return maxValue The highest value in the array
  function getMax(uint32[] storage self) public view returns(uint32 maxValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)
      maxValue := 0

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,8)))

        remainder := mod(i,8)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x00000000000000000000000000000000000000000000000000000000ffffffff,term)
        switch lt(maxValue, term)
        case 1 {
          maxValue := term
        }
      }
    }
  }

  /// @dev Returns the minimum value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return minValue The highest value in the array
  function getMin(uint32[] storage self) public view returns(uint32 minValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,8)))

        remainder := mod(i,8)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,4294967296)
        }

        term := and(0x00000000000000000000000000000000000000000000000000000000ffffffff,term)

        switch eq(i,0)
        case 1 {
          minValue := term
        }
        switch gt(minValue, term)
        case 1 {
          minValue := term
        }
      }
    }
  }

  /// @dev Finds the index of a given value in an array
  /// @param self Storage array containing uint256 type variables
  /// @param value The value to search for
  /// @param isSorted True if the array is sorted, false otherwise
  /// @return found True if the value was found, false otherwise
  /// @return index The index of the given value, returns 0 if found is false
  function indexOf(uint32[] storage self, uint32 value, bool isSorted)
           public
           view
           returns(bool found, uint256 index) {
    if (isSorted) {
        uint256 high = self.length - 1;
        uint256 mid = 0;
        uint256 low = 0;
        while (low <= high) {
          mid = (low+high)/2;
          if (self[mid] == value) {
            found = true;
            index = mid;
            low = high + 1;
          } else if (self[mid] < value) {
            low = mid + 1;
          } else {
            high = mid - 1;
          }
        }
    } else {
      for (uint256 i = 0; i<self.length; i++) {
        if (self[i] == value) {
          found = true;
          index = i;
          i = self.length;
        }
      }
    }
  }

  /// @dev Utility function for heapSort
  /// @param index The index of child node
  /// @return pI The parent node index
  function getParentI(uint256 index) private pure returns (uint256 pI) {
    uint256 i = index - 1;
    pI = i/2;
  }

  /// @dev Utility function for heapSort
  /// @param index The index of parent node
  /// @return lcI The index of left child
  function getLeftChildI(uint256 index) private pure returns (uint256 lcI) {
    uint256 i = index * 2;
    lcI = i + 1;
  }

  /// @dev Sorts given array in place
  /// @param self Storage array containing uint256 type variables
  function heapSort(uint32[] storage self) public {
    uint256 end = self.length - 1;
    uint256 start = getParentI(end);
    uint256 root = start;
    uint256 lChild;
    uint256 rChild;
    uint256 swap;
    uint32 temp;
    while(start >= 0){
      root = start;
      lChild = getLeftChildI(start);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end+1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
      if(start == 0)
        break;
      else
        start = start - 1;
    }
    while(end > 0){
      temp = self[end];
      self[end] = self[0];
      self[0] = temp;
      end = end - 1;
      root = 0;
      lChild = getLeftChildI(0);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end + 1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
    }
  }

  /// @dev Removes duplicates from a given array.
  /// @param self Storage array containing uint256 type variables
  function uniq(uint32[] storage self) public returns (uint256 length) {
    bool contains;
    uint256 index;

    for (uint256 i = 0; i < self.length; i++) {
      (contains, index) = indexOf(self, self[i], false);

      if (i > index) {
        for (uint256 j = i; j < self.length - 1; j++){
          self[j] = self[j + 1];
        }

        delete self[self.length - 1];
        self.length--;
        i--;
      }
    }

    length = self.length;
  }
}

// File: ../sc_datasets/DAppSCAN/consensys-Modular_Interactive_Crowdsale/ethereum-libraries-73abc22623e0841b8ea67a5089002f4867102672/ArrayUtilsLib/truffle/contracts/Array16Lib.sol

pragma solidity ^0.4.18;

/**
 * @title Array16 Library
 * @author Majoolr.io
 *
 * version 1.1.0
 * Copyright (c) 2017 Majoolr, LLC
 * The MIT License (MIT)
 * https://github.com/Majoolr/ethereum-libraries/blob/master/LICENSE
 *
 * The Array16 Library provides a few utility functions to work with
 * storage uint16[] types in place. Majoolr provides smart contract services
 * and security reviews for contract deployments in addition to working on open
 * source projects in the Ethereum community. Our purpose is to test, document,
 * and deploy reusable code onto the blockchain and improve both security and
 * usability. We also educate non-profits, schools, and other community members
 * about the application of blockchain technology.
 * For further information: majoolr.io
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

library Array16Lib {

  /// @dev Sum vector
  /// @param self Storage array containing uint256 type variables
  /// @return sum The sum of all elements, does not check for overflow
  function sumElements(uint16[] storage self) public view returns(uint256 sum) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,16)))

        remainder := mod(i,16)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,65536)
        }

        term := and(0x000000000000000000000000000000000000000000000000000000000000ffff,term)
        sum := add(term,sum)

      }
    }
  }

  /// @dev Returns the max value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return maxValue The highest value in the array
  function getMax(uint16[] storage self) public view returns(uint16 maxValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)
      maxValue := 0

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,16)))

        remainder := mod(i,16)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,65536)
        }

        term := and(0x000000000000000000000000000000000000000000000000000000000000ffff,term)
        switch lt(maxValue, term)
        case 1 {
          maxValue := term
        }
      }
    }
  }

  /// @dev Returns the minimum value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return minValue The highest value in the array
  function getMin(uint16[] storage self) public view returns(uint16 minValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,16)))

        remainder := mod(i,16)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,65536)
        }

        term := and(0x000000000000000000000000000000000000000000000000000000000000ffff,term)

        switch eq(i,0)
        case 1 {
          minValue := term
        }
        switch gt(minValue, term)
        case 1 {
          minValue := term
        }
      }
    }
  }

  /// @dev Finds the index of a given value in an array
  /// @param self Storage array containing uint256 type variables
  /// @param value The value to search for
  /// @param isSorted True if the array is sorted, false otherwise
  /// @return found True if the value was found, false otherwise
  /// @return index The index of the given value, returns 0 if found is false
  function indexOf(uint16[] storage self, uint16 value, bool isSorted)
           public
           view
           returns(bool found, uint256 index) {
    if (isSorted) {
        uint256 high = self.length - 1;
        uint256 mid = 0;
        uint256 low = 0;
        while (low <= high) {
          mid = (low+high)/2;
          if (self[mid] == value) {
            found = true;
            index = mid;
            low = high + 1;
          } else if (self[mid] < value) {
            low = mid + 1;
          } else {
            high = mid - 1;
          }
        }
    } else {
      for (uint256 i = 0; i<self.length; i++) {
        if (self[i] == value) {
          found = true;
          index = i;
          i = self.length;
        }
      }
    }
  }

  /// @dev Utility function for heapSort
  /// @param index The index of child node
  /// @return pI The parent node index
  function getParentI(uint256 index) private pure returns (uint256 pI) {
    uint256 i = index - 1;
    pI = i/2;
  }

  /// @dev Utility function for heapSort
  /// @param index The index of parent node
  /// @return lcI The index of left child
  function getLeftChildI(uint256 index) private pure returns (uint256 lcI) {
    uint256 i = index * 2;
    lcI = i + 1;
  }

  /// @dev Sorts given array in place
  /// @param self Storage array containing uint256 type variables
  function heapSort(uint16[] storage self) public {
    uint256 end = self.length - 1;
    uint256 start = getParentI(end);
    uint256 root = start;
    uint256 lChild;
    uint256 rChild;
    uint256 swap;
    uint16 temp;
    while(start >= 0){
      root = start;
      lChild = getLeftChildI(start);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end+1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
      if(start == 0)
        break;
      else
        start = start - 1;
    }
    while(end > 0){
      temp = self[end];
      self[end] = self[0];
      self[0] = temp;
      end = end - 1;
      root = 0;
      lChild = getLeftChildI(0);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end + 1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
    }
  }

  /// @dev Removes duplicates from a given array.
  /// @param self Storage array containing uint256 type variables
  function uniq(uint16[] storage self) public returns (uint256 length) {
    bool contains;
    uint256 index;

    for (uint256 i = 0; i < self.length; i++) {
      (contains, index) = indexOf(self, self[i], false);

      if (i > index) {
        for (uint256 j = i; j < self.length - 1; j++){
          self[j] = self[j + 1];
        }

        delete self[self.length - 1];
        self.length--;
        i--;
      }
    }

    length = self.length;
  }
}

// File: ../sc_datasets/DAppSCAN/consensys-Modular_Interactive_Crowdsale/ethereum-libraries-73abc22623e0841b8ea67a5089002f4867102672/ArrayUtilsLib/truffle/contracts/Array8Lib.sol

pragma solidity ^0.4.18;

/**
 * @title Array8 Library
 * @author Majoolr.io
 *
 * version 1.1.0
 * Copyright (c) 2017 Majoolr, LLC
 * The MIT License (MIT)
 * https://github.com/Majoolr/ethereum-libraries/blob/master/LICENSE
 *
 * The Array8 Library provides a few utility functions to work with
 * storage uint8[] types in place. Majoolr provides smart contract services
 * and security reviews for contract deployments in addition to working on open
 * source projects in the Ethereum community. Our purpose is to test, document,
 * and deploy reusable code onto the blockchain and improve both security and
 * usability. We also educate non-profits, schools, and other community members
 * about the application of blockchain technology.
 * For further information: majoolr.io
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

library Array8Lib {

  /// @dev Sum vector
  /// @param self Storage array containing uint256 type variables
  /// @return sum The sum of all elements, does not check for overflow
  function sumElements(uint8[] storage self) public view returns(uint256 sum) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,32)))

        remainder := mod(i,32)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,256)
        }

        term := and(0x00000000000000000000000000000000000000000000000000000000000000ff,term)
        sum := add(term,sum)

      }
    }
  }

  /// @dev Returns the max value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return maxValue The highest value in the array
  function getMax(uint8[] storage self) public view returns(uint8 maxValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)
      maxValue := 0

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,32)))

        remainder := mod(i,32)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,256)
        }

        term := and(0x00000000000000000000000000000000000000000000000000000000000000ff,term)
        switch lt(maxValue, term)
        case 1 {
          maxValue := term
        }
      }
    }
  }

  /// @dev Returns the minimum value in an array.
  /// @param self Storage array containing uint256 type variables
  /// @return minValue The highest value in the array
  function getMin(uint8[] storage self) public view returns(uint8 minValue) {
    uint256 term;
    uint8 remainder;

    assembly {
      mstore(0x60,self_slot)

      for { let i := 0 } lt(i, sload(self_slot)) { i := add(i, 1) } {
        term := sload(add(sha3(0x60,0x20),div(i,32)))

        remainder := mod(i,32)

        for { let j := 0 } lt(j, remainder) { j := add(j, 1) } {
          term := div(term,256)
        }

        term := and(0x00000000000000000000000000000000000000000000000000000000000000ff,term)
        switch eq(i,0)
        case 1 {
          minValue := term
        }
        switch gt(minValue, term)
        case 1 {
          minValue := term
        }
      }
    }
  }

  /// @dev Finds the index of a given value in an array
  /// @param self Storage array containing uint256 type variables
  /// @param value The value to search for
  /// @param isSorted True if the array is sorted, false otherwise
  /// @return found True if the value was found, false otherwise
  /// @return index The index of the given value, returns 0 if found is false
  function indexOf(uint8[] storage self, uint8 value, bool isSorted)
           public
           view
           returns(bool found, uint256 index) {
    if (isSorted) {
        uint256 high = self.length - 1;
        uint256 mid = 0;
        uint256 low = 0;
        while (low <= high) {
          mid = (low+high)/2;
          if (self[mid] == value) {
            found = true;
            index = mid;
            low = high + 1;
          } else if (self[mid] < value) {
            low = mid + 1;
          } else {
            high = mid - 1;
          }
        }
    } else {
      for (uint256 i = 0; i<self.length; i++) {
        if (self[i] == value) {
          found = true;
          index = i;
          i = self.length;
        }
      }
    }
  }

  /// @dev Utility function for heapSort
  /// @param index The index of child node
  /// @return pI The parent node index
  function getParentI(uint256 index) private pure returns (uint256 pI) {
    uint256 i = index - 1;
    pI = i/2;
  }

  /// @dev Utility function for heapSort
  /// @param index The index of parent node
  /// @return lcI The index of left child
  function getLeftChildI(uint256 index) private pure returns (uint256 lcI) {
    uint256 i = index * 2;
    lcI = i + 1;
  }

  /// @dev Sorts given array in place
  /// @param self Storage array containing uint256 type variables
  function heapSort(uint8[] storage self) public {
    uint256 end = self.length - 1;
    uint256 start = getParentI(end);
    uint256 root = start;
    uint256 lChild;
    uint256 rChild;
    uint256 swap;
    uint8 temp;
    while(start >= 0){
      root = start;
      lChild = getLeftChildI(start);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end+1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
      if(start == 0)
        break;
      else
        start = start - 1;
    }
    while(end > 0){
      temp = self[end];
      self[end] = self[0];
      self[0] = temp;
      end = end - 1;
      root = 0;
      lChild = getLeftChildI(0);
      while(lChild <= end){
        rChild = lChild + 1;
        swap = root;
        if(self[swap] < self[lChild])
          swap = lChild;
        if((rChild <= end) && (self[swap]<self[rChild]))
          swap = rChild;
        if(swap == root)
          lChild = end + 1;
        else {
          temp = self[swap];
          self[swap] = self[root];
          self[root] = temp;
          root = swap;
          lChild = getLeftChildI(root);
        }
      }
    }
  }

  /// @dev Removes duplicates from a given array.
  /// @param self Storage array containing uint256 type variables
  function uniq(uint8[] storage self) public returns (uint256 length) {
    bool contains;
    uint256 index;

    for (uint256 i = 0; i < self.length; i++) {
      (contains, index) = indexOf(self, self[i], false);

      if (i > index) {
        for (uint256 j = i; j < self.length - 1; j++){
          self[j] = self[j + 1];
        }

        delete self[self.length - 1];
        self.length--;
        i--;
      }
    }

    length = self.length;
  }
}

// File: ../sc_datasets/DAppSCAN/consensys-Modular_Interactive_Crowdsale/ethereum-libraries-73abc22623e0841b8ea67a5089002f4867102672/ArrayUtilsLib/truffle/contracts/ArrayUtilsTestContractTwo.sol

pragma solidity ^0.4.18;






contract ArrayUtilsTestContractTwo {
  using Array256Lib for uint256[];
  using Array128Lib for uint128[];
  using Array64Lib for uint64[];
  using Array32Lib for uint32[];
  using Array16Lib for uint16[];
  using Array8Lib for uint8[];

  uint256[] array256;
  uint128[] array128;
  uint64[] array64;
  uint32[] array32;
  uint16[] array16;
  uint8[] array8;

  event Print(string message, bytes32 test);

  function getSortedIndexOf256(uint256 value) returns (bool,uint256){
    delete array256;
    array256.push(1);
    array256.push(3);
    array256.push(4);
    array256.push(7);
    array256.push(8);
    array256.push(9);
    array256.push(1095);
    return array256.indexOf(value,true);
  }

  function getSortedIndexOf128(uint128 value) returns (bool,uint256) {
    delete array128;
    array128.push(0);
    array128.push(1);
    array128.push(2);
    array128.push(3);
    array128.push(4);
    array128.push(5);
    array128.push(6);
    array128.push(7);
    array128.push(8);
    array128.push(9);
    array128.push(1095);
    return array128.indexOf(value,true);
  }

  function getSortedIndexOf64(uint64 value) returns (bool,uint256) {
    delete array64;
    array64.push(0);
    array64.push(1);
    array64.push(2);
    array64.push(3);
    array64.push(4);
    array64.push(5);
    array64.push(6);
    array64.push(7);
    array64.push(8);
    array64.push(9);
    array64.push(1095);
    return array64.indexOf(value,true);
  }

  function getSortedIndexOf32(uint32 value) returns (bool,uint256) {
    delete array32;
    array32.push(0);
    array32.push(1);
    array32.push(2);
    array32.push(3);
    array32.push(4);
    array32.push(5);
    array32.push(6);
    array32.push(7);
    array32.push(8);
    array32.push(9);
    array32.push(1095);
    return array32.indexOf(value,true);
  }

  function getSortedIndexOf16(uint16 value) returns (bool,uint256) {
    delete array16;
    array16.push(0);
    array16.push(1);
    array16.push(2);
    array16.push(3);
    array16.push(4);
    array16.push(5);
    array16.push(6);
    array16.push(7);
    array16.push(8);
    array16.push(9);
    array16.push(109);
    return array16.indexOf(value,true);
  }

  function getSortedIndexOf8(uint8 value) returns (bool,uint256) {
    delete array8;
    array8.push(0);
    array8.push(1);
    array8.push(2);
    array8.push(3);
    array8.push(4);
    array8.push(5);
    array8.push(6);
    array8.push(7);
    array8.push(8);
    array8.push(9);
    array8.push(109);
    return array8.indexOf(value,true);
  }

  function getUnsortedIndexOf256(uint256 value) returns (bool,uint256) {
    delete array256;
    array256.push(7);
    array256.push(0xffff);
    array256.push(3);
    array256.push(1);
    array256.push(9);
    array256.push(1095);
    return array256.indexOf(value,false);
  }

  function getUnsortedIndexOf64(uint64 value) returns (bool,uint256) {
    delete array64;
    array64.push(7);
    array64.push(0xffff);
    array64.push(3);
    array64.push(1);
    array64.push(9);
    array64.push(1095);
    return array64.indexOf(value,false);
  }

  function getNoIndexOf256(uint256 value, bool isSorted) returns (bool,uint256) {
    delete array256;
    array256.push(1);
    array256.push(3);
    array256.push(4);
    array256.push(7);
    array256.push(9);
    array256.push(1095);
    return array256.indexOf(value,isSorted);
  }

  function getNoIndexOf64(uint64 value, bool isSorted) returns (bool,uint256) {
    delete array64;
    array64.push(1);
    array64.push(3);
    array64.push(4);
    array64.push(7);
    array64.push(9);
    array64.push(1095);
    return array64.indexOf(value,isSorted);
  }

}
