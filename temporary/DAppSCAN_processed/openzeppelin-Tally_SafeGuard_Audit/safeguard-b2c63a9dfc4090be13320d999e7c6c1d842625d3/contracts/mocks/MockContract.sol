// File: ../sc_datasets/DAppSCAN/openzeppelin-Tally_SafeGuard_Audit/safeguard-b2c63a9dfc4090be13320d999e7c6c1d842625d3/contracts/mocks/MockContract.sol

pragma solidity ^0.8.0;

contract MockContract {
    address public lastReceiver;

    function _transfer(address payable _reciver, uint amount) public payable {
        _reciver.transfer(amount);

        lastReceiver = _reciver;
    }
}
