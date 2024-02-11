// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-eb36644a2d8db32c92cc4df936069db8836d0233/contracts/Bytes32SetLib.sol

pragma solidity ^0.5.16;


// https://docs.synthetix.io/contracts/source/libraries/bytes32setlib/
library Bytes32SetLib {
    struct Bytes32Set {
        bytes32[] elements;
        mapping(bytes32 => uint) indices;
    }

    function contains(Bytes32Set storage set, bytes32 candidate) internal view returns (bool) {
        if (set.elements.length == 0) {
            return false;
        }
        uint index = set.indices[candidate];
        return index != 0 || set.elements[0] == candidate;
    }

    function getPage(
        Bytes32Set storage set,
        uint index,
        uint pageSize
    ) internal view returns (bytes32[] memory) {
        // NOTE: This implementation should be converted to slice operators if the compiler is updated to v0.6.0+
        uint endIndex = index + pageSize; // The check below that endIndex <= index handles overflow.

        // If the page extends past the end of the list, truncate it.
        if (endIndex > set.elements.length) {
            endIndex = set.elements.length;
        }
        if (endIndex <= index) {
            return new bytes32[](0);
        }

        uint n = endIndex - index; // We already checked for negative overflow.
        bytes32[] memory page = new bytes32[](n);
        for (uint i; i < n; i++) {
            page[i] = set.elements[i + index];
        }
        return page;
    }

    function add(Bytes32Set storage set, bytes32 element) internal {
        // Adding to a set is an idempotent operation.
        if (!contains(set, element)) {
            set.indices[element] = set.elements.length;
            set.elements.push(element);
        }
    }

    function remove(Bytes32Set storage set, bytes32 element) internal {
        require(contains(set, element), "Element not in set.");
        // Replace the removed element with the last element of the list.
        uint index = set.indices[element];
        uint lastIndex = set.elements.length - 1; // We required that element is in the list, so it is not empty.
        if (index != lastIndex) {
            // No need to shift the last element if it is the one we want to delete.
            bytes32 shiftedElement = set.elements[lastIndex];
            set.elements[index] = shiftedElement;
            set.indices[shiftedElement] = index;
        }
        set.elements.pop();
        delete set.indices[element];
    }
}

// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Shaula Release Smart Contract Audit/synthetix-eb36644a2d8db32c92cc4df936069db8836d0233/contracts/test-helpers/TestableBytes32Set.sol

pragma solidity ^0.5.16;

contract TestableBytes32Set {
    using Bytes32SetLib for Bytes32SetLib.Bytes32Set;

    Bytes32SetLib.Bytes32Set internal set;

    function contains(bytes32 candidate) public view returns (bool) {
        return set.contains(candidate);
    }

    function getPage(uint index, uint pageSize) public view returns (bytes32[] memory) {
        return set.getPage(index, pageSize);
    }

    function add(bytes32 element) public {
        set.add(element);
    }

    function remove(bytes32 element) public {
        set.remove(element);
    }

    function size() public view returns (uint) {
        return set.elements.length;
    }

    function element(uint index) public view returns (bytes32) {
        return set.elements[index];
    }

    function index(bytes32 element) public view returns (uint) {
        return set.indices[element];
    }
}
