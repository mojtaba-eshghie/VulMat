// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-8b766d2e3403b3c1c3a603832c61871be573f4b7/contracts/test-helpers/GenericMock.sol

// Source adapted from  https://github.com/EthWorks/Doppelganger/blob/master/contracts/Doppelganger.sol

pragma solidity ^0.5.16;

contract GenericMock {
    mapping(bytes4 => bytes) public mockConfig;

    // solhint-disable payable-fallback, no-complex-fallback
    function() external {
        bytes memory ret = mockConfig[msg.sig];
        assembly {
            return(add(ret, 0x20), mload(ret))
        }
    }

    function mockReturns(bytes4 key, bytes calldata value) external {
        mockConfig[key] = value;
    }
}
