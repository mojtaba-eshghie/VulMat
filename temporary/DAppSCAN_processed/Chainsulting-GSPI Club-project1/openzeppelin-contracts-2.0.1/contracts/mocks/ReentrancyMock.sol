// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project1/openzeppelin-contracts-2.0.1/contracts/utils/ReentrancyGuard.sol

pragma solidity ^0.4.24;

/**
 * @title Helps contracts guard against reentrancy attacks.
 * @author Remco Bloemen <remco@2π.com>, Eenae <alexey@mixbytes.io>
 * @dev If you mark a function `nonReentrant`, you should also
 * mark it `external`.
 */
contract ReentrancyGuard {

  /// @dev counter to allow mutex lock with only one SSTORE operation
  uint256 private _guardCounter;

  constructor() internal {
    // The counter starts at one to prevent changing it from zero to a non-zero
    // value, which is a more expensive operation.
    _guardCounter = 1;
  }

  /**
   * @dev Prevents a contract from calling itself, directly or indirectly.
   * Calling a `nonReentrant` function from another `nonReentrant`
   * function is not supported. It is possible to prevent this from happening
   * by making the `nonReentrant` function external, and make it call a
   * `private` function that does the actual work.
   */
  modifier nonReentrant() {
    _guardCounter += 1;
    uint256 localCounter = _guardCounter;
    _;
    require(localCounter == _guardCounter);
  }

}

// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project1/openzeppelin-contracts-2.0.1/contracts/mocks/ReentrancyAttack.sol

pragma solidity ^0.4.24;

contract ReentrancyAttack {

  function callSender(bytes4 data) public {
    // solium-disable-next-line security/no-low-level-calls
    require(msg.sender.call(abi.encodeWithSelector(data)));
  }

}

// File: ../sc_datasets/DAppSCAN/Chainsulting-GSPI Club-project1/openzeppelin-contracts-2.0.1/contracts/mocks/ReentrancyMock.sol

pragma solidity ^0.4.24;


contract ReentrancyMock is ReentrancyGuard {

  uint256 public counter;

  constructor() public {
    counter = 0;
  }

  function callback() external nonReentrant {
    count();
  }

  function countLocalRecursive(uint256 n) public nonReentrant {
    if (n > 0) {
      count();
      countLocalRecursive(n - 1);
    }
  }

  function countThisRecursive(uint256 n) public nonReentrant {
    if (n > 0) {
      count();
      // solium-disable-next-line security/no-low-level-calls
      bool result = address(this).call(abi.encodeWithSignature("countThisRecursive(uint256)", n - 1));
      require(result == true);
    }
  }

  function countAndCall(ReentrancyAttack attacker) public nonReentrant {
    count();
    bytes4 func = bytes4(keccak256("callback()"));
    attacker.callSender(func);
  }

  function count() private {
    counter += 1;
  }

}
