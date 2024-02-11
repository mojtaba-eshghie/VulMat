// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Misc_AMOs/keeper/IKToken.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;

interface IKToken {
    function underlying() external view returns (address);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function mint(address recipient, uint256 amount) external returns (bool);
    function burnFrom(address sender, uint256 amount) external;
    function addMinter(address sender) external;
    function renounceMinter() external;
}

// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-FraxFinance/frax-solidity-3f0993a70e3496fd27887db7754d68709c84015e/contracts/Misc_AMOs/keeper/IkUSDC_Partial.sol

// SPDX-License-Identifier: MIT
pragma solidity 0.6.11;
pragma experimental ABIEncoderV2;

// Original at https://etherscan.io/address/0xac826952bc30504359a099c3a486d44E97415c77#code
// Some functions were omitted for brevity. See the contract for details

interface IkUSDC_Partial is IKToken  {

}
