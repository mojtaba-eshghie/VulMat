// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/Assertive.sol

pragma solidity ^0.4.18;
contract Assertive {
  function assert(bool assertion) {
    if (!assertion) throw;
  }
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/Owned.sol

pragma solidity ^0.4.18;

// @title Owned

contract Owned is Assertive {
  address internal owner;
  event SetOwner(address indexed previousOwner, address indexed newOwner);
  function Owned () {
    owner = msg.sender;
  }
  modifier onlyOwner {
    assert(msg.sender == owner);
    _;
  }
  function setOwner(address newOwner) onlyOwner {
    SetOwner(owner, newOwner);
    owner = newOwner;
  }
  function getOwner() returns (address out) {
    return owner;
  }
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/interface/TokenRecipient.sol

pragma solidity ^0.4.18;

contract TokenRecipient {
  function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData);
}

// File: ../sc_datasets/DAppSCAN/Callisto_Network-IDEX Security Audit/idex-4a05eb28e570e9820066474ff2adc924ce7a27bd/lib/TokenBase.sol

pragma solidity ^0.4.18;


contract TokenBase is Owned {
    bytes32 public standard = 'Token 0.1';
    bytes32 public name;
    bytes32 public symbol;
    bool public allowTransactions;
    uint256 public totalSupply;

    event Approval(address indexed from, address indexed spender, uint256 amount);

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function transfer(address _to, uint256 _value) returns (bool success);
    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success);
    function approve(address _spender, uint256 _value) returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success);

    function () {
        throw;
    }
}
