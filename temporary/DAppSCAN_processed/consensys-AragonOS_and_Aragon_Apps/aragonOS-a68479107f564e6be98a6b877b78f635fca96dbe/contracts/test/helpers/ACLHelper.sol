// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/acl/IACLOracle.sol

/*
 * SPDX-License-Identitifer:    MIT
 */

pragma solidity ^0.4.24;


interface IACLOracle {
    function canPerform(address who, address where, bytes32 what, uint256[] how) external view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/consensys-AragonOS_and_Aragon_Apps/aragonOS-a68479107f564e6be98a6b877b78f635fca96dbe/contracts/test/helpers/ACLHelper.sol

pragma solidity 0.4.24;

contract ACLHelper {
    function encodeOperator(uint256 param1, uint256 param2) internal pure returns (uint240) {
        return encodeIfElse(param1, param2, 0);
    }

    function encodeIfElse(uint256 condition, uint256 successParam, uint256 failureParam) internal pure returns (uint240) {
        return uint240(condition + (successParam << 32) + (failureParam << 64));
    }
}


contract AcceptOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        return true;
    }
}


contract RejectOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        return false;
    }
}


contract RevertOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        revert();
    }
}

// Can't implement from IACLOracle as its canPerform() is marked as view-only
contract StateModifyingOracle /* is IACLOracle */ {
    bool modifyState;

    function canPerform(address, address, bytes32, uint256[]) external returns (bool) {
        modifyState = true;
        return true;
    }
}

contract EmptyDataReturnOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[]) external view returns (bool) {
        assembly {
            return(0, 0)
        }
    }
}

contract ConditionalOracle is IACLOracle {
    function canPerform(address, address, bytes32, uint256[] how) external view returns (bool) {
        return how[0] > 0;
    }
}
