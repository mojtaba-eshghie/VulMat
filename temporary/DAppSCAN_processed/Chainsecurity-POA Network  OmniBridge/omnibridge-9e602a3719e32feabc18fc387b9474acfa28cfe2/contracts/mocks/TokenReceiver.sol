// File: ../sc_datasets/DAppSCAN/Chainsecurity-POA Network  OmniBridge/omnibridge-9e602a3719e32feabc18fc387b9474acfa28cfe2/contracts/interfaces/IERC20Receiver.sol

pragma solidity 0.7.5;

interface IERC20Receiver {
    function onTokenBridged(
        address token,
        uint256 value,
        bytes calldata data
    ) external;
}

// File: ../sc_datasets/DAppSCAN/Chainsecurity-POA Network  OmniBridge/omnibridge-9e602a3719e32feabc18fc387b9474acfa28cfe2/contracts/mocks/TokenReceiver.sol

pragma solidity 0.7.5;

contract TokenReceiver is IERC20Receiver {
    address public token;
    address public from;
    uint256 public value;
    bytes public data;

    function onTokenBridged(
        address _token,
        uint256 _value,
        bytes memory _data
    ) external override {
        token = _token;
        from = msg.sender;
        value = _value;
        data = _data;
    }
}
