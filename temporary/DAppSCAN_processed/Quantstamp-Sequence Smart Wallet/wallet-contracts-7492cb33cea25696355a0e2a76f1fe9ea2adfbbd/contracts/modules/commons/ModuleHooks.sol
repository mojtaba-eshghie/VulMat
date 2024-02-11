// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/modules/commons/interfaces/IModuleHooks.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


interface IModuleHooks {
  /**
   * @notice Reads the implementation hook of a signature
   * @param _signature Signature function
   * @return The address of the implementation hook, address(0) if none
  */
  function readHook(bytes4 _signature) external view returns (address);

  /**
   * @notice Adds a new hook to handle a given function selector
   * @param _signature Signature function linked to the hook
   * @param _implementation Hook implementation contract
   */
  function addHook(bytes4 _signature, address _implementation) external;

  /**
   * @notice Removes a registered hook
   * @param _signature Signature function linked to the hook
   */
  function removeHook(bytes4 _signature) external;
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/modules/commons/ModuleSelfAuth.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


contract ModuleSelfAuth {
  modifier onlySelf() {
    require(msg.sender == address(this), "ModuleSelfAuth#onlySelf: NOT_AUTHORIZED");
    _;
  }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/modules/commons/ModuleStorage.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;


library ModuleStorage {
  function writeBytes32(bytes32 _key, bytes32 _val) internal {
    assembly { sstore(_key, _val) }
  }

  function readBytes32(bytes32 _key) internal view returns (bytes32 val) {
    assembly { val := sload(_key) }
  }

  function writeBytes32Map(bytes32 _key, bytes32 _subKey, bytes32 _val) internal {
    bytes32 key = keccak256(abi.encode(_key, _subKey));
    assembly { sstore(key, _val) }
  }

  function readBytes32Map(bytes32 _key, bytes32 _subKey) internal view returns (bytes32 val) {
    bytes32 key = keccak256(abi.encode(_key, _subKey));
    assembly { val := sload(key) }
  }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/modules/commons/ModuleERC165.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;
pragma experimental ABIEncoderV2;


abstract contract ModuleERC165 {
  /**
   * @notice Query if a contract implements an interface
   * @param _interfaceID The interface identifier, as specified in ERC-165
   * @dev Adding new hooks will not lead to them being reported by this function
   *      without upgrading the wallet. In addition, developpers must ensure that 
   *      all inherited contracts by the mainmodule don't conflict and are accounted
   *      to be supported by the supportsInterface method.
   * @return `true` if the contract implements `_interfaceID`
   */
  function supportsInterface(bytes4 _interfaceID) virtual public pure returns (bool) {
    return _interfaceID == this.supportsInterface.selector;
  }
}

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

// File: ../sc_datasets/DAppSCAN/Quantstamp-Sequence Smart Wallet/wallet-contracts-7492cb33cea25696355a0e2a76f1fe9ea2adfbbd/contracts/modules/commons/ModuleHooks.sol

// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.7.6;





contract ModuleHooks is IERC1155Receiver, IERC721Receiver, IModuleHooks, ModuleERC165, ModuleSelfAuth {
  //                       HOOKS_KEY = keccak256("org.arcadeum.module.hooks.hooks");
  bytes32 private constant HOOKS_KEY = bytes32(0xbe27a319efc8734e89e26ba4bc95f5c788584163b959f03fa04e2d7ab4b9a120);

  /**
   * @notice Reads the implementation hook of a signature
   * @param _signature Signature function
   * @return The address of the implementation hook, address(0) if none
  */
  function readHook(bytes4 _signature) external override view returns (address) {
    return _readHook(_signature);
  }

  /**
   * @notice Adds a new hook to handle a given function selector
   * @param _signature Signature function linked to the hook
   * @param _implementation Hook implementation contract
   * @dev Can't overwrite hooks that are part of the mainmodule (those defined below)
   */
  function addHook(bytes4 _signature, address _implementation) external override onlySelf {
    require(_readHook(_signature) == address(0), "ModuleHooks#addHook: HOOK_ALREADY_REGISTERED");
    _writeHook(_signature, _implementation);
  }

  /**
   * @notice Removes a registered hook
   * @param _signature Signature function linked to the hook
   * @dev Can't remove hooks that are part of the mainmodule (those defined below) 
   *      without upgrading the wallet
   */
  function removeHook(bytes4 _signature) external override onlySelf {
    require(_readHook(_signature) != address(0), "ModuleHooks#removeHook: HOOK_NOT_REGISTERED");
    _writeHook(_signature, address(0));
  }

  /**
   * @notice Reads the implementation hook of a signature
   * @param _signature Signature function
   * @return The address of the implementation hook, address(0) if none
  */
  function _readHook(bytes4 _signature) private view returns (address) {
    return address(uint256(ModuleStorage.readBytes32Map(HOOKS_KEY, _signature)));
  }

  /**
   * @notice Writes the implementation hook of a signature
   * @param _signature Signature function
   * @param _implementation Hook implementation contract
  */
  function _writeHook(bytes4 _signature, address _implementation) private {
    ModuleStorage.writeBytes32Map(HOOKS_KEY, _signature, bytes32(uint256(_implementation)));
  }

  /**
   * @notice Handle the receipt of a single ERC1155 token type.
   * @return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
   */
  function onERC1155Received(
    address,
    address,
    uint256,
    uint256,
    bytes calldata
  ) external override returns (bytes4) {
    return ModuleHooks.onERC1155Received.selector;
  }

  /**
   * @notice Handle the receipt of multiple ERC1155 token types.
   * @return `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
   */
  function onERC1155BatchReceived(
    address,
    address,
    uint256[] calldata,
    uint256[] calldata,
    bytes calldata
  ) external override returns (bytes4) {
    return ModuleHooks.onERC1155BatchReceived.selector;
  }

  /**
   * @notice Handle the receipt of a single ERC721 token.
   * @return `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
   */
  function onERC721Received(address, address, uint256, bytes calldata) external override returns (bytes4) {
    return ModuleHooks.onERC721Received.selector;
  }

  /**
   * @notice Routes fallback calls through hooks
   */
  fallback() external payable {
    address target = _readHook(msg.sig);
    if (target != address(0)) {
      (bool success, bytes memory result) = target.delegatecall(msg.data);
      assembly {
        if iszero(success)  {
          revert(add(result, 0x20), mload(result))
        }

        return(add(result, 0x20), mload(result))
      }
    }
  }

  /**
   * @notice Allows the wallet to receive ETH
   */
  receive() external payable { }

  /**
   * @notice Query if a contract implements an interface
   * @param _interfaceID The interface identifier, as specified in ERC-165
   * @return `true` if the contract implements `_interfaceID`
   */
  function supportsInterface(bytes4 _interfaceID) public override virtual pure returns (bool) {
    if (
      _interfaceID == type(IModuleHooks).interfaceId ||
      _interfaceID == type(IERC1155Receiver).interfaceId ||
      _interfaceID == type(IERC721Receiver).interfaceId ||
      _interfaceID == type(IERC223Receiver).interfaceId
    ) {
      return true;
    }

    return super.supportsInterface(_interfaceID);
  }
}
