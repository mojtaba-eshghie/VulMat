// File: ../sc_datasets/DAppSCAN/Quantstamp-Atomic Loans/atomicloans-eth-contracts-10c2493d6851dcf59ee3d99519f0228b4bc2afaf/contracts/Compound/Oracles/_DSValue.sol

pragma solidity ^0.5.10;

contract _DSValue {
    // TODO: View or constant? It's clearly a view...
    function peek() public view returns (bytes32, bool);

    function read() public view returns (bytes32);
}
