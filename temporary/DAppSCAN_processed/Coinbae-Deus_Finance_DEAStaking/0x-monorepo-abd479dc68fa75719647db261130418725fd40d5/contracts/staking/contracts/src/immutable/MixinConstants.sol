// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/immutable/MixinDeploymentConstants.sol

/*

  Copyright 2019 ZeroEx Intl.

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


contract MixinDeploymentConstants {

    // @TODO SET THESE VALUES FOR DEPLOYMENT

    uint256 constant internal EPOCH_DURATION_IN_SECONDS = 1000;

    uint256 constant internal TIMELOCK_DURATION_IN_EPOCHS = 3;

    // How much delegated stake is weighted vs operator stake, in ppm.
    uint32 constant internal REWARD_DELEGATED_STAKE_WEIGHT = 900000; // 90%

    uint256 constant internal CHAIN_ID = 1;

    uint256 constant internal MAX_MAKERS_IN_POOL = 10;
}

// File: ../sc_datasets/DAppSCAN/Coinbae-Deus_Finance_DEAStaking/0x-monorepo-abd479dc68fa75719647db261130418725fd40d5/contracts/staking/contracts/src/immutable/MixinConstants.sol

/*

  Copyright 2019 ZeroEx Intl.

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

contract MixinConstants is
    MixinDeploymentConstants
{
    uint32 constant internal PPM_DENOMINATOR = 1000000;

    // The upper 16 bytes represent the pool id, so this would be pool id 1. See MixinStakinPool for more information.
    bytes32 constant internal INITIAL_POOL_ID = 0x0000000000000000000000000000000100000000000000000000000000000000;

    // The upper 16 bytes represent the pool id, so this would be an increment of 1. See MixinStakinPool for more information.
    uint256 constant internal POOL_ID_INCREMENT_AMOUNT = 0x0000000000000000000000000000000100000000000000000000000000000000;

    bytes32 constant internal NIL_POOL_ID = 0x0000000000000000000000000000000000000000000000000000000000000000;

    address constant internal NIL_ADDRESS = 0x0000000000000000000000000000000000000000;

    bytes32 constant internal UNKNOWN_STAKING_POOL_ID = 0x0000000000000000000000000000000000000000000000000000000000000000;

    uint64 constant internal INITIAL_EPOCH = 0;

    uint64 constant internal INITIAL_TIMELOCK_PERIOD = INITIAL_EPOCH;

    uint256 constant internal MIN_TOKEN_VALUE = 10**18;
}
