// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/core/diaspore/interfaces/LoanCallback.sol

pragma solidity ^0.5.11;


interface LoanCallback {
    function scheme() external view returns (string memory);

    function onLent(
        bytes32 _id,
        address _lender,
        bytes calldata _data
    ) external returns (bool);

    function acceptsLoan(
        address _engine,
        bytes32 _id,
        address _lender,
        bytes calldata _data
    ) external view returns (bool);
}
