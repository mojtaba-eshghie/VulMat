// File: ../sc_datasets/DAppSCAN/consensys-0x_Protocol_v2/0x-monorepo-a05b14e4d9659be1cc495ee33fd8962ce773f87f/packages/metacoin/contracts/Metacoin.sol

pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

contract Metacoin {
    mapping (address => uint) public balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    struct TransferData {
        address to;
        uint256 amount;
    }

    struct NestedTransferData {
        TransferData transferData;
        uint32 callback;
    }

    constructor () public {
        balances[msg.sender] = 10000;
    }

    function transfer(TransferData transferData) public returns (bool success) {
        if (balances[msg.sender] < transferData.amount) return false;
        balances[msg.sender] -= transferData.amount;
        balances[transferData.to] += transferData.amount;
        emit Transfer(msg.sender, transferData.to, transferData.amount);
        return true;
    }

    function transfer(TransferData transferData, uint32 callback) public returns (int) {
        transfer(transferData);
        return callback;
    }

    function transfer(NestedTransferData nestedTransferData) public returns (int) {
        return transfer(nestedTransferData.transferData, nestedTransferData.callback);
    }

}
