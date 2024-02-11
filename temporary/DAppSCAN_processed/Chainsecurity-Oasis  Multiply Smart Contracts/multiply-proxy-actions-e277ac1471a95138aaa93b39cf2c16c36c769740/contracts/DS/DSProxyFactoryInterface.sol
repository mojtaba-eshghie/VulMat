// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/DS/DSAuthority.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract DSAuthority {
  function canCall(
    address src,
    address dst,
    bytes4 sig
  ) public view virtual returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/DS/DSAuth.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract DSAuthEvents {
  event LogSetAuthority(address indexed authority);
  event LogSetOwner(address indexed owner);
}

contract DSAuth is DSAuthEvents {
  DSAuthority public authority;
  address public owner;

  constructor() {
    owner = msg.sender;
    emit LogSetOwner(msg.sender);
  }

  function setOwner(address owner_) public auth {
    owner = owner_;
    emit LogSetOwner(owner);
  }

  function setAuthority(DSAuthority authority_) public auth {
    authority = authority_;
    emit LogSetAuthority(address(authority));
  }

  modifier auth {
    require(isAuthorized(msg.sender, msg.sig), 'Not authorized');
    _;
  }

  function isAuthorized(address src, bytes4 sig) internal view returns (bool) {
    if (src == address(this)) {
      return true;
    } else if (src == owner) {
      return true;
    } else if (authority == DSAuthority(0)) {
      return false;
    } else {
      return authority.canCall(src, address(this), sig);
    }
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/DS/DSNote.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

contract DSNote {
  event LogNote(
    bytes4 indexed sig,
    address indexed guy,
    bytes32 indexed foo,
    bytes32 indexed bar,
    uint256 wad,
    bytes fax
  ) anonymous;

  modifier note {
    bytes32 foo;
    bytes32 bar;

    assembly {
      foo := calldataload(4)
      bar := calldataload(36)
    }

    emit LogNote(msg.sig, msg.sender, foo, bar, msg.value, msg.data);

    _;
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/DS/DSProxy.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;


abstract contract DSProxy is DSAuth, DSNote {
  DSProxyCache public cache; // global cache for contracts

  constructor(address _cacheAddr) {
    require(setCache(_cacheAddr), 'Cache not set');
  }

  // solhint-disable-next-line no-empty-blocks
  receive() external payable {}

  // use the proxy to execute calldata _data on contract _code
  function execute(bytes memory _code, bytes memory _data)
    public
    payable
    virtual
    returns (address target, bytes32 response);

  function execute(address _target, bytes memory _data)
    public
    payable
    virtual
    returns (bytes32 response);

  //set new cache
  function setCache(address _cacheAddr) public payable virtual returns (bool);
}

contract DSProxyCache {
  mapping(bytes32 => address) cache;

  function read(bytes memory _code) public view returns (address) {
    bytes32 hash = keccak256(_code);
    return cache[hash];
  }

  function write(bytes memory _code) public returns (address target) {
    assembly {
      target := create(0, add(_code, 0x20), mload(_code))
      switch iszero(extcodesize(target))
      case 1 {
        // throw if contract failed to deploy
        revert(0, 0)
      }
    }
    bytes32 hash = keccak256(_code);
    cache[hash] = target;
  }
}

// File: ../sc_datasets/DAppSCAN/Chainsecurity-Oasis  Multiply Smart Contracts/multiply-proxy-actions-e277ac1471a95138aaa93b39cf2c16c36c769740/contracts/DS/DSProxyFactoryInterface.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

abstract contract DSProxyFactoryInterface {
  function build(address owner) public virtual returns (DSProxy proxy);
}
