// File: ../sc_datasets/DAppSCAN/Quantstamp-Skale Network/skale-manager-2558730986d1fe96ef091f252b7c11450d8a57f0/contracts/Decryption.sol

/*
    Decryption.sol - SKALE Manager
    Copyright (C) 2018-Present SKALE Labs
    @author Artem Payvin

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

pragma solidity ^0.5.0;


contract Decryption {

    function encrypt(uint256 secretNumber, bytes32 key) external pure returns (bytes32 ciphertext) {
        bytes32 numberBytes = bytes32(secretNumber);
        bytes memory tmp = new bytes(32);
        for (uint8 i = 0; i < 32; i++) {
            tmp[i] = numberBytes[i] ^ key[i];
        }
        assembly {
            ciphertext := mload(add(tmp, 32))
        }
    }

    function decrypt(bytes32 ciphertext, bytes32 key) external pure returns (uint256 secretNumber) {
        bytes memory tmp = new bytes(32);
        for (uint8 i = 0; i < 32; i++) {
            tmp[i] = ciphertext[i] ^ key[i];
        }
        bytes32 numberBytes;
        assembly {
            numberBytes := mload(add(tmp, 32))
        }
        secretNumber = uint256(numberBytes);
    }
}
