// File: ../sc_datasets/DAppSCAN/Coinfabrik-RCN Network Smart Contract Audit/rcn-network-master/rcn-network-master/contracts/utils/IsContract.sol

pragma solidity ^0.5.11;


library IsContract {
    function isContract(address _addr) internal view returns (bool) {
        uint size;
        assembly { size := extcodesize(_addr) }
        return size > 0;
    }
}
