// File: ../sc_datasets/DAppSCAN/PeckShield-AstridDAO/contracts-main/contracts-main/contracts/Interfaces/IPool.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

// Common interface for the Pools.
interface IPool {
    
    // --- Events ---
    
    event COLBalanceUpdated(uint _newBalance);
    event BAIBalanceUpdated(uint _newBalance);
    event ActivePoolAddressChanged(address _newActivePoolAddress);
    event DefaultPoolAddressChanged(address _newDefaultPoolAddress);
    event StabilityPoolAddressChanged(address _newStabilityPoolAddress);
    event COLSent(address _to, uint _amount);

    // --- Functions ---
    
    function getCOL() external view returns (uint);

    function getBAIDebt() external view returns (uint);

    function increaseBAIDebt(uint _amount) external;

    function decreaseBAIDebt(uint _amount) external;

    // --- For support of ERC20 ---
    function receiveCOL(uint _amount) external;
    // Fallback payment functions should be disabled.
}

// File: ../sc_datasets/DAppSCAN/PeckShield-AstridDAO/contracts-main/contracts-main/contracts/Interfaces/IDefaultPool.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

interface IDefaultPool is IPool {
    // --- Events ---
    event VaultManagerAddressChanged(address _newVaultManagerAddress);
    event COLTokenAddressChanged(address _newCOLTokenAddress);
    event DefaultPoolBAIDebtUpdated(uint _BAIDebt);
    event DefaultPoolCOLBalanceUpdated(uint _COL);

    // --- Functions ---
    function sendCOLToActivePool(uint _amount) external;
}
