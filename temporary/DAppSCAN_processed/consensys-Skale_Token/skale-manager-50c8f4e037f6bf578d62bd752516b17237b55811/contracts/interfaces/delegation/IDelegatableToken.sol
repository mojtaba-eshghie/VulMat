// File: ../sc_datasets/DAppSCAN/consensys-Skale_Token/skale-manager-50c8f4e037f6bf578d62bd752516b17237b55811/contracts/interfaces/delegation/IDelegatableToken.sol

/*
    IDelegatableToken.sol - SKALE Manager
    Copyright (C) 2019-Present SKALE Labs
    @author Dmytro Stebaiev

    SKALE Manager is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published
    by the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    SKALE Manager is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with SKALE Manager.  If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity ^0.5.3;

interface IDelegatableToken {

    function getLockedOf(address wallet) external returns (uint);

    function getDelegatedOf(address wallet) external returns (uint);

    function getSlashedOf(address wallet) external returns (uint);
}
