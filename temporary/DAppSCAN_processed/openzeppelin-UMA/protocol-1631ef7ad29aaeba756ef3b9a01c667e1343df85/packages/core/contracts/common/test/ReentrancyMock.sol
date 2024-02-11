// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA/protocol-1631ef7ad29aaeba756ef3b9a01c667e1343df85/packages/core/contracts/common/implementation/Lockable.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

/**
 * @title A contract that provides modifiers to prevent reentrancy to state-changing and view-only methods. This contract
 * is inspired by https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuard.sol
 * and https://github.com/balancer-labs/balancer-core/blob/master/contracts/BPool.sol.
 */
contract Lockable {
    bool private _notEntered;

    constructor() internal {
        // Storing an initial non-zero value makes deployment a bit more
        // expensive, but in exchange the refund on every call to nonReentrant
        // will be lower in amount. Since refunds are capped to a percetange of
        // the total transaction's gas, it is best to keep them low in cases
        // like this one, to increase the likelihood of the full refund coming
        // into effect.
        _notEntered = true;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        _preEntranceCheck();
        _preEntranceSet();
        _;
        _postEntranceReset();
    }

    /**
     * @dev Designed to prevent a view-only method from being re-entered during a call to a `nonReentrant()` state-changing method.
     */
    modifier nonReentrantView() {
        _preEntranceCheck();
        _;
    }

    // Internal methods are used to avoid copying the require statement's bytecode to every `nonReentrant()` method.
    // On entry into a function, `_preEntranceCheck()` should always be called to check if the function is being re-entered.
    // Then, if the function modifies state, it should call `_postEntranceSet()`, perform its logic, and then call `_postEntranceReset()`.
    // View-only methods can simply call `_preEntranceCheck()` to make sure that it is not being re-entered.
    function _preEntranceCheck() internal view {
        // On the first call to nonReentrant, _notEntered will be true
        require(_notEntered, "ReentrancyGuard: reentrant call");
    }

    function _preEntranceSet() internal {
        // Any calls to nonReentrant after this point will fail
        _notEntered = false;
    }

    function _postEntranceReset() internal {
        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _notEntered = true;
    }
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA/protocol-1631ef7ad29aaeba756ef3b9a01c667e1343df85/packages/core/contracts/common/test/ReentrancyAttack.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;

// Tests reentrancy guards defined in Lockable.sol.
// Copied from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.1/contracts/mocks/ReentrancyAttack.sol.
contract ReentrancyAttack {
    function callSender(bytes4 data) public {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, ) = msg.sender.call(abi.encodeWithSelector(data));
        require(success, "ReentrancyAttack: failed call");
    }
}

// File: ../sc_datasets/DAppSCAN/openzeppelin-UMA/protocol-1631ef7ad29aaeba756ef3b9a01c667e1343df85/packages/core/contracts/common/test/ReentrancyMock.sol

// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.6.0;


// Tests reentrancy guards defined in Lockable.sol.
// Extends https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.1/contracts/mocks/ReentrancyMock.sol.
contract ReentrancyMock is Lockable {
    uint256 public counter;

    constructor() public {
        counter = 0;
    }

    function callback() external nonReentrant {
        _count();
    }

    function countAndSend(ReentrancyAttack attacker) external nonReentrant {
        _count();
        bytes4 func = bytes4(keccak256("callback()"));
        attacker.callSender(func);
    }

    function countAndCall(ReentrancyAttack attacker) external nonReentrant {
        _count();
        bytes4 func = bytes4(keccak256("getCount()"));
        attacker.callSender(func);
    }

    function countLocalRecursive(uint256 n) public nonReentrant {
        if (n > 0) {
            _count();
            countLocalRecursive(n - 1);
        }
    }

    function countThisRecursive(uint256 n) public nonReentrant {
        if (n > 0) {
            _count();
            // solhint-disable-next-line avoid-low-level-calls
            (bool success, ) = address(this).call(abi.encodeWithSignature("countThisRecursive(uint256)", n - 1));
            require(success, "ReentrancyMock: failed call");
        }
    }

    function countLocalCall() public nonReentrant {
        getCount();
    }

    function countThisCall() public nonReentrant {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, ) = address(this).call(abi.encodeWithSignature("getCount()"));
        require(success, "ReentrancyMock: failed call");
    }

    function getCount() public view nonReentrantView returns (uint256) {
        return counter;
    }

    function _count() private {
        counter += 1;
    }
}
