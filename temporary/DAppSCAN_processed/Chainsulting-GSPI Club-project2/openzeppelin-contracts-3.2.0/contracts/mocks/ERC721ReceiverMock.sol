// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project2/openzeppelin-contracts-3.2.0/contracts/token/ERC721/IERC721Receiver.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data)
    external returns (bytes4);
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project2/openzeppelin-contracts-3.2.0/contracts/mocks/ERC721ReceiverMock.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract ERC721ReceiverMock is IERC721Receiver {
    bytes4 private _retval;
    bool private _reverts;

    event Received(address operator, address from, uint256 tokenId, bytes data, uint256 gas);

    constructor (bytes4 retval, bool reverts) public {
        _retval = retval;
        _reverts = reverts;
    }

    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
        public override returns (bytes4)
    {
        require(!_reverts, "ERC721ReceiverMock: reverting");
        emit Received(operator, from, tokenId, data, gasleft());
        return _retval;
    }
}
