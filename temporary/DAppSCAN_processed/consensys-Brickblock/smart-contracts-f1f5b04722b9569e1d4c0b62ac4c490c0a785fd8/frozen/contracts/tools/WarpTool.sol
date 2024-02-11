// File: ../sc_datasets/DAppSCAN/consensys-Brickblock/smart-contracts-f1f5b04722b9569e1d4c0b62ac4c490c0a785fd8/frozen/contracts/tools/WarpTool.sol

pragma solidity ^0.4.18;


// used to change state and move block forward in testrpc
contract WarpTool {

  bool public state;

  function warp()
    public
  {
    state = !state;
  }

}
