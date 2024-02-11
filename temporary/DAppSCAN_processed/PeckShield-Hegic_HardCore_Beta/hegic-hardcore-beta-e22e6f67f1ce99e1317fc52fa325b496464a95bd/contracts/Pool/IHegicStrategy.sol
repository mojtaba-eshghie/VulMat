// File: ../sc_datasets/DAppSCAN/PeckShield-Hegic_HardCore_Beta/hegic-hardcore-beta-e22e6f67f1ce99e1317fc52fa325b496464a95bd/contracts/Pool/IHegicStrategy.sol

pragma solidity 0.8.6;

/**
 * SPDX-License-Identifier: GPL-3.0-or-later
 * Hegic
 * Copyright (C) 2022 Hegic Protocol
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **/

interface IHegicStrategy {

    event Acquired(
      uint256 indexed id,
      uint256 amount,
      uint256 premium,
      uint256 strike,
      uint32 expiration
    );

    function getLockedByStrategy() external view returns (uint256 amount);

    function lockedLimit() external view returns (uint lockedLimit);

}
