// File: ../sc_datasets/DAppSCAN/Chainsecurity-Angle Protocol  Borrowing Module/angle-borrow-0363b6a137a44e22ee06b3187ba74f7798c1af08/contracts/mock/MockKeeperMulticall2.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.12;

contract MockKeeperMulticall2 {
    uint256 public testVar = 1;

    bytes32 public constant KEEPER_ROLE = keccak256("KEEPER_ROLE");

    //solhint-disable-next-line
    address private constant _oneInch = 0x1111111254fb6c44bAC0beD2854e76F90643097d;

    struct Action {
        address target;
        bytes data;
        bool isDelegateCall;
    }

    event LogAction(address indexed target, bytes data);
    event SentToMiner(uint256 indexed value);
    event Recovered(address indexed tokenAddress, address indexed to, uint256 amount);

    error AmountOutTooLow(uint256 amount, uint256 min);
    error BalanceTooLow();
    error FlashbotsErrorPayingMiner(uint256 value);
    error IncompatibleLengths();
    error RevertBytes();
    error ZeroAddress();

    function test() external pure returns (bool) {
        return true;
    }
}
