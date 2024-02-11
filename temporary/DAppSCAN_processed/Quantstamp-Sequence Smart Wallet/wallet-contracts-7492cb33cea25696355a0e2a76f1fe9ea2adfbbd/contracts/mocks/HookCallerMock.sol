// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/interfaces/receivers/IERC1155Receiver.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


interface IERC1155Receiver {
  function onERC1155Received(address, address, uint256, uint256, bytes calldata) external returns (bytes4);
  function onERC1155BatchReceived(address, address, uint256[] calldata, uint256[] calldata, bytes calldata) external returns (bytes4);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/interfaces/receivers/IERC721Receiver.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


interface IERC721Receiver {
  function onERC721Received(address, address, uint256, bytes calldata) external returns (bytes4);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/interfaces/receivers/IERC223Receiver.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


interface IERC223Receiver {
  function tokenFallback(address, uint256, bytes calldata) external;
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/interfaces/IERC1271Wallet.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


interface IERC1271Wallet {

  /**
   * @notice Verifies whether the provided signature is valid with respect to the provided data
   * @dev MUST return the correct magic value if the signature provided is valid for the provided data
   *   > The bytes4 magic value to return when signature is valid is 0x20c13b0b : bytes4(keccak256("isValidSignature(bytes,bytes)")
   *   > This function MAY modify Ethereum's state
   * @param _data       Arbitrary length data signed on the behalf of address(this)
   * @param _signature  Signature byte array associated with _data
   * @return magicValue Magic value 0x20c13b0b if the signature is valid and 0x0 otherwise
   */
  function isValidSignature(
    bytes calldata _data,
    bytes calldata _signature)
    external
    view
    returns (bytes4 magicValue);

  /**
   * @notice Verifies whether the provided signature is valid with respect to the provided hash
   * @dev MUST return the correct magic value if the signature provided is valid for the provided hash
   *   > The bytes4 magic value to return when signature is valid is 0x20c13b0b : bytes4(keccak256("isValidSignature(bytes,bytes)")
   *   > This function MAY modify Ethereum's state
   * @param _hash       keccak256 hash that was signed
   * @param _signature  Signature byte array associated with _data
   * @return magicValue Magic value 0x20c13b0b if the signature is valid and 0x0 otherwise
   */
  function isValidSignature(
    bytes32 _hash,
    bytes calldata _signature)
    external
    view
    returns (bytes4 magicValue);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/mocks/HookCallerMock.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;



contract HookCallerMock {
  function callERC1155Received(address _addr) external {
    bytes4 result = IERC1155Receiver(_addr).onERC1155Received(
      address(this),
      msg.sender,
      1,
      2,
      msg.data
    );

    require(result == 0xf23a6e61, "HookCallerMock#callERC1155Received: INVALID_RETURN");
  }

  function callERC1155BatchReceived(address _addr) external {
    uint256[] memory ids = new uint256[](3);
    ids[0] = 1;
    ids[1] = 2;
    ids[2] = 3;

    uint256[] memory values = new uint256[](3);
    values[0] = 200;
    values[1] = 300;
    values[2] = 400;

    bytes4 result = IERC1155Receiver(_addr).onERC1155BatchReceived(
      address(this),
      msg.sender,
      ids,
      values,
      msg.data
    );

    require(result == 0xbc197c81, "HookCallerMock#callERC1155BatchReceived: INVALID_RETURN");
  }

  function callERC721Received(address _addr) external {
    bytes4 result = IERC721Receiver(_addr).onERC721Received(
      address(this),
      msg.sender,
      1,
      msg.data
    );

    require(result == 0x150b7a02, "HookCallerMock#callERC721Received: INVALID_RETURN");
  }

  function callERC223Received(address _addr) external {
    IERC223Receiver(_addr).tokenFallback(msg.sender, 1, msg.data);
  }

  function callERC1271isValidSignatureData(
    address _addr,
    bytes calldata _data,
    bytes calldata _signature
  ) external view {
    bytes4 result = IERC1271Wallet(_addr).isValidSignature(_data, _signature);
    require(result == 0x20c13b0b, "HookCallerMock#callERC1271isValidSignatureData: INVALID_RETURN");
  }

  function callERC1271isValidSignatureHash(
    address _addr,
    bytes32 _hash,
    bytes calldata _signature
  ) external view {
    bytes4 result = IERC1271Wallet(_addr).isValidSignature(_hash, _signature);
    require(result == 0x1626ba7e, "HookCallerMock#callERC1271isValidSignatureHash: INVALID_RETURN");
  }
}
