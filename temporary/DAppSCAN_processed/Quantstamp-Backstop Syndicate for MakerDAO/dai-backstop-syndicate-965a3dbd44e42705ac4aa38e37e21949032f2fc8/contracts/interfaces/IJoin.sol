// File: ../sc_datasets/DAppSCAN/Quantstamp-Backstop Syndicate for MakerDAO/dai-backstop-syndicate-965a3dbd44e42705ac4aa38e37e21949032f2fc8/contracts/interfaces/IJoin.sol

pragma solidity 0.5.16;


interface IJoin {
    function join(address, uint256) external;
    function exit(address, uint256) external;
}
