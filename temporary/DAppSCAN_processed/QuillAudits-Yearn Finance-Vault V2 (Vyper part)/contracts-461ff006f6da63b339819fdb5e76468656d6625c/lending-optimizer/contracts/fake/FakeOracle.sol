// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Vault V2 (Vyper part)/contracts-461ff006f6da63b339819fdb5e76468656d6625c/lending-optimizer/contracts/fake/FakeOracle.sol

pragma solidity ^0.6.6;

interface ILimaToken {
    function receiveOracleData(bytes32 _requestId, bytes32 _data) external;
}

contract FakeOracle {
    bytes32 public constant REQUEST_ID = bytes32("fake");

    function requestDeliveryStatus(address _receiver)
        external
        returns (bytes32 requestId)
    {
        return REQUEST_ID;
    }

    function fakeCallToReceiveOracleData(
        address _limaToken,
        bytes32 _data
    ) external {
        ILimaToken(_limaToken).receiveOracleData(REQUEST_ID, _data);
    }
}
