// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-GnosisSafe/safe-contracts-427d6f7e779431333c54bcb4d4cde31e4d57ce96/contracts/common/SecuredTokenTransfer.sol

pragma solidity ^0.5.0;


/// @title SecuredTokenTransfer - Secure token transfer
/// @author Richard Meissner - <richard@gnosis.pm>
contract SecuredTokenTransfer {

    /// @dev Transfers a token and returns if it was a success
    /// @param token Token that should be transferred
    /// @param receiver Receiver to whom the token should be transferred
    /// @param amount The amount of tokens that should be transferred
    function transferToken (
        address token, 
        address receiver,
        uint256 amount
    )
        internal
        returns (bool transferred)
    {
        bytes memory data = abi.encodeWithSignature("transfer(address,uint256)", receiver, amount);
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let success := call(sub(gas, 10000), token, 0, add(data, 0x20), mload(data), 0, 0)
            let ptr := mload(0x40)
            returndatacopy(ptr, 0, returndatasize)
            switch returndatasize 
            case 0 { transferred := success }
            case 0x20 { transferred := iszero(or(iszero(success), iszero(mload(ptr)))) }
            default { transferred := 0 }
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-GnosisSafe/safe-contracts-427d6f7e779431333c54bcb4d4cde31e4d57ce96/contracts/proxies/Proxy.sol

pragma solidity ^0.5.0;


/// @title Proxy - Generic proxy contract allows to execute all transactions applying the code of a master contract.
/// @author Stefan George - <stefan@gnosis.pm>
contract Proxy {

    // masterCopy always needs to be first declared variable, to ensure that it is at the same location in the contracts to which calls are delegated.
    address masterCopy;

    /// @dev Constructor function sets address of master copy contract.
    /// @param _masterCopy Master copy address.
    constructor(address _masterCopy)
        public
    {
        require(_masterCopy != address(0), "Invalid master copy address provided");
        masterCopy = _masterCopy;
    }

    /// @dev Fallback function forwards all transactions and returns all received return data.
    function ()
        external
        payable
    {
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            let masterCopy := and(sload(0), 0xffffffffffffffffffffffffffffffffffffffff)
            calldatacopy(0, 0, calldatasize())
            let success := delegatecall(gas, masterCopy, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            if eq(success, 0) { revert(0, returndatasize()) }
            return(0, returndatasize())
        }
    }

    function implementation()
        public
        view
        returns (address)
    {
        return masterCopy;
    }

    function proxyType()
        public
        pure
        returns (uint256)
    {
        return 2;
    }
}

// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-GnosisSafe/safe-contracts-427d6f7e779431333c54bcb4d4cde31e4d57ce96/contracts/proxies/DelegateConstructorProxy.sol

pragma solidity ^0.5.0;

/// @title Delegate Constructor Proxy - Generic proxy contract allows to execute all transactions applying the code of a master contract. It is possible to send along initialization data with the constructor.
/// @author Stefan George - <stefan@gnosis.pm>
/// @author Richard Meissner - <richard@gnosis.pm>
contract DelegateConstructorProxy is Proxy {

    /// @dev Constructor function sets address of master copy contract.
    /// @param _masterCopy Master copy address.
    /// @param initializer Data used for a delegate call to initialize the contract.
    constructor(address _masterCopy, bytes memory initializer) Proxy(_masterCopy)
        public
    {
        if (initializer.length > 0) {
            // solium-disable-next-line security/no-inline-assembly
            assembly {
                let masterCopy := and(sload(0), 0xffffffffffffffffffffffffffffffffffffffff)
                let success := delegatecall(sub(gas, 10000), masterCopy, add(initializer, 0x20), mload(initializer), 0, 0)
                let ptr := mload(0x40)
                returndatacopy(ptr, 0, returndatasize)
                if eq(success, 0) { revert(ptr, returndatasize) }
            }
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Runtime_Vеrification-GnosisSafe/safe-contracts-427d6f7e779431333c54bcb4d4cde31e4d57ce96/contracts/proxies/PayingProxy.sol

pragma solidity ^0.5.0;


/// @title Paying Proxy - Generic proxy contract allows to execute all transactions applying the code of a master contract. It is possible to send along initialization data with the constructor. And sends funds after creation to a specified account.
/// @author Stefan George - <stefan@gnosis.pm>
/// @author Richard Meissner - <richard@gnosis.pm>
contract PayingProxy is DelegateConstructorProxy, SecuredTokenTransfer {

    /// @dev Constructor function sets address of master copy contract.
    /// @param _masterCopy Master copy address.
    /// @param initializer Data used for a delegate call to initialize the contract.
    /// @param funder Address that should be paid for the execution of this call
    /// @param paymentToken Token that should be used for the payment (0 is ETH)
    /// @param payment Value that should be paid
    constructor(address _masterCopy, bytes memory initializer, address payable funder, address paymentToken, uint256 payment) 
        DelegateConstructorProxy(_masterCopy, initializer)
        public
    {
        if (payment > 0) {
            if (paymentToken == address(0)) {
                 // solium-disable-next-line security/no-send
                require(funder.send(payment), "Could not pay safe creation with ether");
            } else {
                require(transferToken(paymentToken, funder, payment), "Could not pay safe creation with token");
            }
        } 
    }
}
