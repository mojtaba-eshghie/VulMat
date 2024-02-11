// File: ../sc_datasets/DAppSCAN/QuillAudits-Yearn Finance-Yearn Protocol V1/yearn-protocol-9ff0dc0ea73642c529383d0675930a41bf033295/interfaces/curve/Curve.sol

// SPDX-License-Identifier: MIT

pragma solidity ^0.5.17;

interface ICurveFi {

  function get_virtual_price() external view returns (uint);
  function add_liquidity( // sBTC pool
    uint256[3] calldata amounts,
    uint256 min_mint_amount
  ) external;
  function add_liquidity( // bUSD pool
    uint256[4] calldata amounts,
    uint256 min_mint_amount
  ) external;
  function remove_liquidity_imbalance(
    uint256[4] calldata amounts,
    uint256 max_burn_amount
  ) external;
  function remove_liquidity(
    uint256 _amount,
    uint256[4] calldata amounts
  ) external;
  function exchange(
    int128 from, int128 to, uint256 _from_amount, uint256 _min_to_amount
  ) external;
}
