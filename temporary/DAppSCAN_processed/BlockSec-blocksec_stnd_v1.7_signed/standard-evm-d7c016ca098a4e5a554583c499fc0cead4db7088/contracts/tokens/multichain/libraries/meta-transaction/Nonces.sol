// File: ../sc_datasets/DAppSCAN/BlockSec-blocksec_stnd_v1.7_signed/standard-evm-d7c016ca098a4e5a554583c499fc0cead4db7088/contracts/tokens/multichain/libraries/meta-transaction/Nonces.sol

// SPDX-License-Identifier: Apache-2.0

// File: contracts/lib/Nonces.sol

pragma solidity 0.6.12;

abstract contract Nonces {
    mapping(address => uint256) internal _nonces;

    /**
     * @notice Nonces for permit / meta-transactions
     * @param owner Token owner's address
     * @return Next nonce
     */
    function nonces(address owner) external view returns (uint256) {
        return _nonces[owner];
    }
}
