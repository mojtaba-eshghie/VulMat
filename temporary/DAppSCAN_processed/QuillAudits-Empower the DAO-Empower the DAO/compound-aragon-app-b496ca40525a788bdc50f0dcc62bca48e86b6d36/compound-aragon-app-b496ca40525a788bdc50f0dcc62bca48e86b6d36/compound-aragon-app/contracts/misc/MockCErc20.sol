// File: ../sc_datasets/DAppSCAN/QuillAudits-Empower the DAO-Empower the DAO/compound-aragon-app-b496ca40525a788bdc50f0dcc62bca48e86b6d36/compound-aragon-app-b496ca40525a788bdc50f0dcc62bca48e86b6d36/compound-aragon-app/contracts/CErc20Interface.sol

pragma solidity ^0.4.24;

contract CErc20Interface {

    address public underlying;

}

// File: ../sc_datasets/DAppSCAN/QuillAudits-Empower the DAO-Empower the DAO/compound-aragon-app-b496ca40525a788bdc50f0dcc62bca48e86b6d36/compound-aragon-app-b496ca40525a788bdc50f0dcc62bca48e86b6d36/compound-aragon-app/contracts/misc/MockCErc20.sol

pragma solidity ^0.4.24;

contract MockCErc20 is CErc20Interface {

    constructor(address _underlying) public {
        underlying = _underlying;
    }

    function mint(uint mintAmount) external returns (uint) {
        return 0;
    }
}
