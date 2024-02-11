// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-75e51e722d316eb45713049faf5e430ed124794e/contracts/Owned.sol

pragma solidity ^0.5.16;

// https://docs.synthetix.io/contracts/source/contracts/owned
contract Owned {
    address public owner;
    address public nominatedOwner;

    constructor(address _owner) public {
        require(_owner != address(0), "Owner address cannot be 0");
        owner = _owner;
        emit OwnerChanged(address(0), _owner);
    }

    function nominateNewOwner(address _owner) external onlyOwner {
        nominatedOwner = _owner;
        emit OwnerNominated(_owner);
    }

    function acceptOwnership() external {
        require(msg.sender == nominatedOwner, "You must be nominated before you can accept ownership");
        emit OwnerChanged(owner, nominatedOwner);
        owner = nominatedOwner;
        nominatedOwner = address(0);
    }

    modifier onlyOwner {
        _onlyOwner();
        _;
    }

    function _onlyOwner() private view {
        require(msg.sender == owner, "Only the contract owner may perform this action");
    }

    event OwnerNominated(address newOwner);
    event OwnerChanged(address oldOwner, address newOwner);
}

// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-75e51e722d316eb45713049faf5e430ed124794e/contracts/BaseMigration.sol

pragma solidity ^0.5.16;

contract BaseMigration is Owned {
    address public deployer;

    constructor(address _owner) internal Owned(_owner) {
        deployer = msg.sender;
    }

    // safety value to return ownership (anyone can invoke)
    function returnOwnership(address forContract) external {
        bytes memory payload = abi.encodeWithSignature("nominateNewOwner(address)", owner);

        // solhint-disable avoid-low-level-calls
        (bool success, ) = forContract.call(payload);

        if (!success) {
            // then try legacy way
            bytes memory legacyPayload = abi.encodeWithSignature("nominateOwner(address)", owner);

            // solhint-disable avoid-low-level-calls
            (bool legacySuccess, ) = forContract.call(legacyPayload);

            require(legacySuccess, "Legacy nomination failed");
        }
    }

    function _requireDeployer() private view {
        require(msg.sender == deployer, "Only the deployer can invoke this");
    }

    modifier onlyDeployer() {
        _requireDeployer();
        _;
    }
}

// File: ../sc_datasets/DAppSCAN/Iosiro-Synthetix Alnitak Release Smart Contract Audit/synthetix-75e51e722d316eb45713049faf5e430ed124794e/contracts/test-helpers/MockMigration.sol

pragma solidity ^0.5.16;


contract MockMigration is BaseMigration {
    constructor(address _owner) public BaseMigration(_owner) {}

    function canOnlyBeRunByDeployer() external onlyDeployer {}

    function acceptOwnership(address someContract) external {
        Owned(someContract).acceptOwnership();
    }
}
