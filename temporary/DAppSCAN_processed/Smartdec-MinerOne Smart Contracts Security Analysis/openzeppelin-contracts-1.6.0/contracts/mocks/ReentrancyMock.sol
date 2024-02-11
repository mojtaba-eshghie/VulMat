// File: ../sc_datasets/DAppSCAN/Smartdec-MinerOne Smart Contracts Security Analysis/openzeppelin-contracts-1.6.0/contracts/ReentrancyGuard.sol

pragma solidity ^0.4.18;


/**
 * @title Helps contracts guard agains reentrancy attacks.
 * @author Remco Bloemen <remco@2π.com>
 * @notice If you mark a function `nonReentrant`, you should also
 * mark it `external`.
 */
contract ReentrancyGuard {

  /**
   * @dev We use a single lock for the whole contract.
   */
  bool private reentrancy_lock = false;

  /**
   * @dev Prevents a contract from calling itself, directly or indirectly.
   * @notice If you mark a function `nonReentrant`, you should also
   * mark it `external`. Calling one nonReentrant function from
   * another is not supported. Instead, you can implement a
   * `private` function doing the actual work, and a `external`
   * wrapper marked as `nonReentrant`.
   */
  modifier nonReentrant() {
    require(!reentrancy_lock);
    reentrancy_lock = true;
    _;
    reentrancy_lock = false;
  }

}

// File: ../sc_datasets/DAppSCAN/Smartdec-MinerOne Smart Contracts Security Analysis/openzeppelin-contracts-1.6.0/contracts/mocks/ReentrancyAttack.sol

pragma solidity ^0.4.18;


contract ReentrancyAttack {

  function callSender(bytes4 data) public {
    require(msg.sender.call(data));
  }

}

// File: ../sc_datasets/DAppSCAN/Smartdec-MinerOne Smart Contracts Security Analysis/openzeppelin-contracts-1.6.0/contracts/mocks/ReentrancyMock.sol

pragma solidity ^0.4.18;


contract ReentrancyMock is ReentrancyGuard {

  uint256 public counter;

  function ReentrancyMock() public {
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
    bytes4 func = bytes4(keccak256("countThisRecursive(uint256)"));
    if (n > 0) {
      count();
      bool result = this.call(func, n - 1);
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
