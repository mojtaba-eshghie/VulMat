// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-f7ca254108de47c3cf99f950fa329aaa57391cf0/contracts/project/ProjectWallet.sol

pragma solidity ^0.4.24;

contract ProjectWallet {

    function transfer(address _receiver, uint256 _amt) public returns (bool);

}

// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-f7ca254108de47c3cf99f950fa329aaa57391cf0/contracts/mocks/MockProjectWallet.sol

pragma solidity ^0.4.24;

contract MockProjectWallet {

    uint public called = 0;
    address sender;
    address receiver;
    uint256 amt;

    constructor(address _sender, address _receiver, uint256 _amt) public {
        sender = _sender;
        receiver = _receiver;
        amt = _amt;
    }

    function transfer(address _sender, address _receiver, uint256 _amt) public returns (bool)
    {
        require(sender == _sender, "sender mismatch");
        require(receiver == _receiver, "receiver mismatch");
        require(amt == _amt, "amt mismatch");
        called = called + 1;
        return true;
    }

}
