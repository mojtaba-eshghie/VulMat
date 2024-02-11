// File: ../sc_datasets/DAppSCAN/Chainsulting-UNILAYERX/openzeppelin-contracts-2.3.0/contracts/utils/ReentrancyGuard.sol

pragma solidity ^0.5.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the `nonReentrant` modifier
 * available, which can be aplied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 */
contract ReentrancyGuard {
    /// @dev counter to allow mutex lock with only one SSTORE operation
    uint256 private _guardCounter;

    constructor () internal {
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
        require(localCounter == _guardCounter, "ReentrancyGuard: reentrant call");
    }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-UNILAYERX/openzeppelin-contracts-2.3.0/contracts/mocks/ReentrancyAttack.sol

pragma solidity ^0.5.0;

contract ReentrancyAttack {
    function callSender(bytes4 data) public {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success,) = msg.sender.call(abi.encodeWithSelector(data));
        require(success, "ReentrancyAttack: failed call");
    }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-UNILAYERX/openzeppelin-contracts-2.3.0/contracts/mocks/ReentrancyMock.sol

pragma solidity ^0.5.0;


contract ReentrancyMock is ReentrancyGuard {
    uint256 public counter;

    constructor () public {
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
            // solhint-disable-next-line avoid-low-level-calls
            (bool success,) = address(this).call(abi.encodeWithSignature("countThisRecursive(uint256)", n - 1));
            require(success, "ReentrancyMock: failed call");
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
