// File: ../sc_datasets/DAppSCAN/Quantstamp-NAOS-Formation Updates/NAOS-Formation-c1404ec0f5de6f80189b528acf5f0923ff8d4e6e/contracts/interfaces/ICurveMetaFactory.sol

pragma solidity 0.6.12;

interface ICurveMetaFactory {
    event MetaPoolDeployed(address coin, address base_pool, uint256 A, uint256 fee, address deployer);

    function deploy_metapool(
        address _base_pool,
        string calldata _name,
        string calldata _symbol,
        address _coin,
        uint256 _A,
        uint256 _fee
    ) external returns (address);
}
