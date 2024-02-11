// File: ../sc_datasets/DAppSCAN/Chainsulting-SPICE/synthetix-develop/contracts/interfaces/IERC20.sol

pragma solidity >=0.4.24;

// https://docs.synthetix.io/contracts/source/interfaces/ierc20
interface IERC20 {
    // ERC20 Optional Views
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    // Views
    function totalSupply() external view returns (uint);

    function balanceOf(address owner) external view returns (uint);

    function allowance(address owner, address spender) external view returns (uint);

    // Mutative functions
    function transfer(address to, uint value) external returns (bool);

    function approve(address spender, uint value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint value
    ) external returns (bool);

    // Events
    event Transfer(address indexed from, address indexed to, uint value);

    event Approval(address indexed owner, address indexed spender, uint value);
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-SPICE/synthetix-develop/contracts/interfaces/IWrapper.sol

pragma solidity >=0.4.24;

// https://docs.synthetix.io/contracts/source/interfaces/iwrapper
interface IWrapper {
    function mint(uint amount) external;

    function burn(uint amount) external;

    function capacity() external view returns (uint);

    function totalIssuedSynths() external view returns (uint);

    function calculateMintFee(uint amount) external view returns (uint, bool);

    function calculateBurnFee(uint amount) external view returns (uint, bool);

    function maxTokenAmount() external view returns (uint256);

    function mintFeeRate() external view returns (int256);

    function burnFeeRate() external view returns (int256);
}
