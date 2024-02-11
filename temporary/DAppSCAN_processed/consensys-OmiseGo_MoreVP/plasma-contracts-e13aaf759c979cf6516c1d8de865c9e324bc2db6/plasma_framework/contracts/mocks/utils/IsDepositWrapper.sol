// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/src/utils/IsDeposit.sol

pragma solidity 0.5.11;

library IsDeposit {
    struct Predicate {
        uint256 childBlockInterval;
    }

    /**
     * @notice Tests whether the given block number belongs to a deposit block
     */
    function test(Predicate memory _predicate, uint256 _blockNum) internal pure returns (bool) {
        return _blockNum % _predicate.childBlockInterval != 0;
    }
}

// File: ../sc_datasets/DAppSCAN/consensys-OmiseGo_MoreVP/plasma-contracts-e13aaf759c979cf6516c1d8de865c9e324bc2db6/plasma_framework/contracts/mocks/utils/IsDepositWrapper.sol

pragma solidity 0.5.11;

contract IsDepositWrapper {
    using IsDeposit for IsDeposit.Predicate;

    IsDeposit.Predicate internal isDeposit;

    constructor(uint256 _childBlockInterval) public {
        isDeposit = IsDeposit.Predicate(_childBlockInterval);
    }

    function test(uint256 _blockNum) public view returns (bool) {
        return isDeposit.test(_blockNum);
    }
}
