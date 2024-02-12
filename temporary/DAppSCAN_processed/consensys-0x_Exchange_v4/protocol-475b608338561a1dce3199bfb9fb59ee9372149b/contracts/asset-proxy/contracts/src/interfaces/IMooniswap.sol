// File: ../sc_datasets/DAppSCAN/consensys-0x_Exchange_v4/protocol-475b608338561a1dce3199bfb9fb59ee9372149b/contracts/asset-proxy/contracts/src/interfaces/IMooniswap.sol

/*

  Copyright 2020 ZeroEx Intl.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

pragma solidity ^0.5.9;


interface IMooniswapRegistry {

    function pools(address token1, address token2) external view returns(address);
}


interface IMooniswap {

    function swap(
        address fromToken,
        address destToken,
        uint256 amount,
        uint256 minReturn,
        address referral
    )
        external
        payable
        returns(uint256 returnAmount);
}