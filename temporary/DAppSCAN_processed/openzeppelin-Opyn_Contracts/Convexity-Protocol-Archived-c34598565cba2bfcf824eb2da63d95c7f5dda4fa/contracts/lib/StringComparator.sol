// File: ../sc_datasets/DAppSCAN/openzeppelin-Opyn_Contracts/Convexity-Protocol-Archived-c34598565cba2bfcf824eb2da63d95c7f5dda4fa/contracts/lib/StringComparator.sol

pragma solidity 0.5.10;

library StringComparator {
    function compareStrings (string memory a, string memory b) public pure
       returns (bool) {
        return keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b)));
    }
}
