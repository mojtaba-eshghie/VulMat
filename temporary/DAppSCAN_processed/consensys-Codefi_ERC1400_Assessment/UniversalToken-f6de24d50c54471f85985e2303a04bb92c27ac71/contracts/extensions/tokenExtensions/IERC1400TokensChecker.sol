// File: ../sc_datasets/DAppSCAN/consensys-Codefi_ERC1400_Assessment/UniversalToken-f6de24d50c54471f85985e2303a04bb92c27ac71/contracts/extensions/tokenExtensions/IERC1400TokensChecker.sol

/*
 * This code has not been reviewed.
 * Do not use or deploy this code before reviewing it personally first.
 */
pragma solidity ^0.5.0;

/**
 * @title IERC1400TokensChecker
 * @dev IERC1400TokensChecker interface
 */
interface IERC1400TokensChecker {

  // function canTransfer(
  //   bytes4 functionSig,
  //   address operator,
  //   address from,
  //   address to,
  //   uint256 value,
  //   bytes calldata data,
  //   bytes calldata operatorData
  // ) external view returns (byte, bytes32);

  function canTransferByPartition(
    bytes4 functionSig,
    bytes32 partition,
    address operator,
    address from,
    address to,
    uint256 value,
    bytes calldata data,
    bytes calldata operatorData
    ) external view returns (byte, bytes32, bytes32);

}
