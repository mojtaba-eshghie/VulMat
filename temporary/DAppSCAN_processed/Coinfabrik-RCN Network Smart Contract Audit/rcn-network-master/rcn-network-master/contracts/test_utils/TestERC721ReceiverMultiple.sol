// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/test_utils/IERC721Receiver.sol

/* solium-disable */
pragma solidity ^0.5.11;


interface IERC721Receiver {
    function onERC721Received(
        address _operator,
        address _from,
        uint256 _tokenId,
        bytes calldata _userData
    )
        external returns (bytes4);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/test_utils/IERC721ReceiverLegacy.sol

/* solium-disable */
pragma solidity ^0.5.11;


interface IERC721ReceiverLegacy {
    function onERC721Received(
        address _from,
        uint256 _tokenId,
        bytes calldata _userData
    )
        external returns (bytes4);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/test_utils/TestERC721ReceiverMultiple.sol

/* solium-disable */
pragma solidity ^0.5.11;


contract TestERC721ReceiverMultiple is IERC721Receiver, IERC721ReceiverLegacy {
    address public lastOperator;
    address public lastFrom;
    uint256 public lastTokenId;
    uint256 public methodCalled;
    bytes public lastData;

    event Received(address _operator, address _from, uint256 _id, bytes _data);

    function onERC721Received(
        address _operator,
        address _from,
        uint256 _tokenId,
        bytes calldata _userData
    ) external returns (bytes4) {
        emit Received(
            _operator,
            _from,
            _tokenId,
            _userData
        );
        lastOperator = _operator;
        lastFrom = _from;
        lastTokenId = _tokenId;
        lastData = _userData;
        methodCalled = 2;
        return bytes4(0x150b7a02);
    }

    function onERC721Received(
        address _from,
        uint256 _tokenId,
        bytes calldata _userData
    ) external returns (bytes4) {
        lastFrom = _from;
        lastTokenId = _tokenId;
        lastData = _userData;
        methodCalled = 1;
        return bytes4(0xf0b9e5ba);
    }
}
