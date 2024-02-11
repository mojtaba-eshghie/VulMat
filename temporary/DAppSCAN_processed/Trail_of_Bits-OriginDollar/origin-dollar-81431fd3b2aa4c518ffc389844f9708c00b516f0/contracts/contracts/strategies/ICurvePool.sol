// File: ../sc_datasets/DAppSCAN/Trail_of_Bits-OriginDollar/origin-dollar-81431fd3b2aa4c518ffc389844f9708c00b516f0/contracts/contracts/strategies/ICurvePool.sol

pragma solidity 0.5.11;

interface ICurvePool {
    function get_virtual_price() external returns (uint256);

    function add_liquidity(uint256[3] calldata _amounts, uint256 _min) external;

    function calc_token_amount(uint256[3] calldata _amounts, bool _deposit)
        external
        returns (uint256);

    function remove_liquidity_one_coin(
        uint256 _amount,
        int128 _index,
        uint256 _minAmount
    ) external;

    function calc_withdraw_one_coin(uint256 _amount, int128 _index)
        external
        view
        returns (uint256);

    function coins(uint256 _index) external view returns (address);
}
