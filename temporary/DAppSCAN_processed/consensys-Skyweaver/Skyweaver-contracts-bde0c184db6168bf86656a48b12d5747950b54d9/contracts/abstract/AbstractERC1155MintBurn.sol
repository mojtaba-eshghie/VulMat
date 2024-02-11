// File: ../sc_datasets/DAppSCAN/consensys-Skyweaver/Skyweaver-contracts-bde0c184db6168bf86656a48b12d5747950b54d9/contracts/abstract/AbstractERC1155MintBurn.sol

pragma solidity ^0.5.16;


contract AbstractERC1155MintBurn {
    function _mint(address, uint256, uint256, bytes memory) internal;
    function _batchMint(address, uint256[] memory, uint256[] memory, bytes memory) internal;
    function _burn(address, uint256, uint256) internal;
    function _batchBurn(address, uint256[] memory, uint256[] memory) internal;
}
