// File: ../sc_datasets/DAppSCAN/Quantstamp-Backstop Syndicate for MakerDAO/dai-backstop-syndicate-965a3dbd44e42705ac4aa38e37e21949032f2fc8/contracts/interfaces/IVat.sol

pragma solidity 0.5.16;


interface IVat {
    function dai(address) external view returns (uint256);
    function hope(address) external;
    function move(address, address, uint256) external;
}
