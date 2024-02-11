// File: ../sc_datasets/DAppSCAN/consensys-Skale_Token/skale-manager-50c8f4e037f6bf578d62bd752516b17237b55811/contracts/ECDH.sol

/*
    ECDH.sol - SKALE Manager
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

pragma solidity ^0.5.3;


contract ECDH {

    uint256 constant GX = 0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798;
    uint256 constant GY = 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8;
    uint256 constant N = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F;
    uint256 constant A = 0;
    // uint256 constant B = 7;

    constructor () public {

    }

    function publicKey(uint256 privKey) external pure returns (uint256 qx, uint256 qy) {
        uint256 x;
        uint256 y;
        uint256 z;
        (x, y, z) = ecMul(
            privKey,
            GX,
            GY,
            1
        );
        z = inverse(z);
        qx = mulmod(x, z, N);
        qy = mulmod(y, z, N);
    }

    function deriveKey(
        uint256 privKey,
        uint256 pubX,
        uint256 pubY
    )
        external
        pure
        returns (uint256 qx, uint256 qy)
    {
        uint256 x;
        uint256 y;
        uint256 z;
        (x, y, z) = ecMul(
            privKey,
            pubX,
            pubY,
            1
        );
        z = inverse(z);
        qx = mulmod(x, z, N);
        qy = mulmod(y, z, N);
    }

    function jAdd(
        uint256 x1,
        uint256 z1,
        uint256 x2,
        uint256 z2
    )
        public
        pure
        returns (uint256 x3, uint256 z3)
    {
        (x3, z3) = (addmod(mulmod(z2, x1, N), mulmod(x2, z1, N), N), mulmod(z1, z2, N));
    }

    function jSub(
        uint256 x1,
        uint256 z1,
        uint256 x2,
        uint256 z2
    )
        public
        pure
        returns (uint256 x3, uint256 z3)
    {
        (x3, z3) = (addmod(mulmod(z2, x1, N), mulmod(N - x2, z1, N), N), mulmod(z1, z2, N));
    }

    function jMul(
        uint256 x1,
        uint256 z1,
        uint256 x2,
        uint256 z2
    )
        public
        pure
        returns (uint256 x3, uint256 z3)
    {
        (x3, z3) = (mulmod(x1, x2, N), mulmod(z1, z2, N));
    }

    function jDiv(
        uint256 x1,
        uint256 z1,
        uint256 x2,
        uint256 z2
    )
        public
        pure
        returns (uint256 x3, uint256 z3)
    {
        (x3, z3) = (mulmod(x1, z2, N), mulmod(z1, x2, N));
    }

    function inverse(uint256 a) public pure returns (uint256 invA) {
        uint256 t = 0;
        uint256 newT = 1;
        uint256 r = N;
        uint256 newR = a;
        uint256 q;
        while (newR != 0) {
            q = r / newR;
            (t, newT) = (newT, addmod(t, (N - mulmod(q, newT, N)), N));
            (r, newR) = (newR, r - q * newR);
        }
        return t;
    }

    function ecAdd(
        uint256 x1,
        uint256 y1,
        uint256 z1,
        uint256 x2,
        uint256 y2,
        uint256 z2
    )
        public
        pure
        returns (uint256 x3, uint256 y3, uint256 z3)
    {
        uint256 ln;
        uint256 lz;
        uint256 da;
        uint256 db;

        if ((x1 == 0) && (y1 == 0)) {
            return (x2, y2, z2);
        }

        if ((x2 == 0) && (y2 == 0)) {
            return (x1, y1, z1);
        }

        if ((x1 == x2) && (y1 == y2)) {
            (ln, lz) = jMul(
                x1,
                z1,
                x1,
                z1
            );
            (ln, lz) = jMul(
                ln,
                lz,
                3,
                1
            );
            (ln, lz) = jAdd(
                ln,
                lz,
                A,
                1
            );
            (da, db) = jMul(
                y1,
                z1,
                2,
                1
            );
        } else {
            (ln, lz) = jSub(
                y2,
                z2,
                y1,
                z1
            );
            (da, db) = jSub(
                x2,
                z2,
                x1,
                z1
            );
        }
        (ln, lz) = jDiv(
            ln,
            lz,
            da,
            db
        );

        (x3, da) = jMul(
            ln,
            lz,
            ln,
            lz
        );
        (x3, da) = jSub(
            x3,
            da,
            x1,
            z1
        );
        (x3, da) = jSub(
            x3,
            da,
            x2,
            z2
        );

        (y3, db) = jSub(
            x1,
            z1,
            x3,
            da
        );
        (y3, db) = jMul(
            y3,
            db,
            ln,
            lz
        );
        (y3, db) = jSub(
            y3,
            db,
            y1,
            z1
        );

        if (da != db) {
            x3 = mulmod(x3, db, N);
            y3 = mulmod(y3, da, N);
            z3 = mulmod(da, db, N);
        } else {
            z3 = da;
        }
    }

    function ecDouble(
        uint256 x1,
        uint256 y1,
        uint256 z1
    )
        public
        pure
        returns (uint256 x3, uint256 y3, uint256 z3)
    {
        (x3, y3, z3) = ecAdd(
            x1,
            y1,
            z1,
            x1,
            y1,
            z1
        );
    }

    function ecMul(
        uint256 d,
        uint256 x1,
        uint256 y1,
        uint256 z1
    )
        public
        pure
        returns (uint256 x3, uint256 y3, uint256 z3)
    {
        uint256 remaining = d;
        uint256 px = x1;
        uint256 py = y1;
        uint256 pz = z1;
        uint256 acx = 0;
        uint256 acy = 0;
        uint256 acz = 1;

        if (d == 0) {
            return (0, 0, 1);
        }

        while (remaining != 0) {
            if ((remaining & 1) != 0) {
                (acx, acy, acz) = ecAdd(
                    acx,
                    acy,
                    acz,
                    px,
                    py,
                    pz
                );
            }
            remaining = remaining / 2;
            (px, py, pz) = ecDouble(px, py, pz);
        }

        (x3, y3, z3) = (acx, acy, acz);
    }
}
