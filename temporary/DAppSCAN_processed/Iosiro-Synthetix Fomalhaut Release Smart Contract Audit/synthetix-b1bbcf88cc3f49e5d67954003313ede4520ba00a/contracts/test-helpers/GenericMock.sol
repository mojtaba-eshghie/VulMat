// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Fomalhaut Release Smart Contract Audit/synthetix-b1bbcf88cc3f49e5d67954003313ede4520ba00a/contracts/test-helpers/GenericMock.sol

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
