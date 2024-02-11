// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/token/interfaces/IERC20.sol

pragma solidity ^0.5.2;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {ERC20Detailed}.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external;

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external;

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external;

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // This function is not a standard ERC20 interface, just for compitable with market.
    function decimals() external view returns (uint8);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/token/ERC20SafeTransfer.sol

pragma solidity ^0.5.2;

contract ERC20SafeTransfer {
    function doTransferOut(
        address _token,
        address _to,
        uint256 _amount
    ) internal returns (bool) {
        IERC20 token = IERC20(_token);
        bool result;

        token.transfer(_to, _amount);

        assembly {
            switch returndatasize()
                case 0 {
                    result := not(0)
                }
                case 32 {
                    returndatacopy(0, 0, 32)
                    result := mload(0)
                }
                default {
                    revert(0, 0)
                }
        }
        return result;
    }

    function doTransferFrom(
        address _token,
        address _from,
        address _to,
        uint256 _amount
    ) internal returns (bool) {
        IERC20 token = IERC20(_token);
        bool result;

        token.transferFrom(_from, _to, _amount);

        assembly {
            switch returndatasize()
                case 0 {
                    result := not(0)
                }
                case 32 {
                    returndatacopy(0, 0, 32)
                    result := mload(0)
                }
                default {
                    revert(0, 0)
                }
        }
        return result;
    }

    function doApprove(
        address _token,
        address _to,
        uint256 _amount
    ) internal returns (bool) {
        IERC20 token = IERC20(_token);
        bool result;

        token.approve(_to, _amount);

        assembly {
            switch returndatasize()
                case 0 {
                    result := not(0)
                }
                case 32 {
                    returndatacopy(0, 0, 32)
                    result := mload(0)
                }
                default {
                    revert(0, 0)
                }
        }
        return result;
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/utility/DSMath.sol

/// math.sol -- mixin for inline numerical wizardry

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.5.2;

contract DSMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, "ds-math-add-overflow");
    }
    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, "ds-math-sub-underflow");
    }
    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, "ds-math-mul-overflow");
    }

    function div(uint x, uint y) internal pure returns (uint z) {
        require(y > 0, "ds-math-div-overflow");
        z = x / y;
    }

    function min(uint x, uint y) internal pure returns (uint z) {
        return x <= y ? x : y;
    }
    function max(uint x, uint y) internal pure returns (uint z) {
        return x >= y ? x : y;
    }
    // function imin(int x, int y) internal pure returns (int z) {
    //     return x <= y ? x : y;
    // }
    // function imax(int x, int y) internal pure returns (int z) {
    //     return x >= y ? x : y;
    // }

    uint constant WAD = 10 ** 18;
    // uint constant RAY = 10 ** 27;

    // function wmul(uint x, uint y) internal pure returns (uint z) {
    //     z = add(mul(x, y), WAD / 2) / WAD;
    // }
    // function rmul(uint x, uint y) internal pure returns (uint z) {
    //     z = add(mul(x, y), RAY / 2) / RAY;
    // }
    function wdiv(uint x, uint y) internal pure returns (uint z) {
        z = add(mul(x, WAD), y / 2) / y;
    }
    // function rdiv(uint x, uint y) internal pure returns (uint z) {
    //     z = add(mul(x, RAY), y / 2) / y;
    // }

    // This famous algorithm is called "exponentiation by squaring"
    // and calculates x^n with x as fixed-point and n as regular unsigned.
    //
    // It's O(log n), instead of O(n) for naive repeated multiplication.
    //
    // These facts are why it works:
    //
    //  If n is even, then x^n = (x^2)^(n/2).
    //  If n is odd,  then x^n = x * x^(n-1),
    //   and applying the equation for even x gives
    //    x^n = x * (x^2)^((n-1) / 2).
    //
    //  Also, EVM division is flooring and
    //    floor[(n-1) / 2] = floor[n / 2].
    //
    // function rpow(uint _x, uint n) internal pure returns (uint z) {
    //     uint x = _x;
    //     z = n % 2 != 0 ? x : RAY;

    //     for (n /= 2; n != 0; n /= 2) {
    //         x = rmul(x, x);

    //         if (n % 2 != 0) {
    //             z = rmul(z, x);
    //         }
    //     }
    // }

    /**
     * @dev x to the power of y power(base, exponent)
     */
    function pow(uint256 base, uint256 exponent) public pure returns (uint256) {
        if (exponent == 0) {
            return 1;
        }
        else if (exponent == 1) {
            return base;
        }
        else if (base == 0 && exponent != 0) {
            return 0;
        }
        else {
            uint256 z = base;
            for (uint256 i = 1; i < exponent; i++)
                z = mul(z, base);
            return z;
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/utility/DSAuth.sol

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.5.2;

contract DSAuthority {
    function canCall(
        address src, address dst, bytes4 sig
    ) public view returns (bool);
}

contract DSAuthEvents {
    event LogSetAuthority (address indexed authority);
    event LogSetOwner     (address indexed owner);
    event OwnerUpdate     (address indexed owner, address indexed newOwner);
}

contract DSAuth is DSAuthEvents {
    DSAuthority  public  authority;
    address      public  owner;
    address      public  newOwner;

    constructor() public {
        owner = msg.sender;
        emit LogSetOwner(msg.sender);
    }

    // Warning: you should absolutely sure you want to give up authority!!!
    function disableOwnership() public onlyOwner {
        owner = address(0);
        emit OwnerUpdate(msg.sender, owner);
    }

    function transferOwnership(address newOwner_) public onlyOwner {
        require(newOwner_ != owner, "TransferOwnership: the same owner.");
        newOwner = newOwner_;
    }

    function acceptOwnership() public {
        require(msg.sender == newOwner, "AcceptOwnership: only new owner do this.");
        emit OwnerUpdate(owner, newOwner);
        owner = newOwner;
        newOwner = address(0x0);
    }

    ///[snow] guard is Authority who inherit DSAuth.
    function setAuthority(DSAuthority authority_)
        public
        onlyOwner
    {
        authority = authority_;
        emit LogSetAuthority(address(authority));
    }

    modifier onlyOwner {
        require(isOwner(msg.sender), "ds-auth-non-owner");
        _;
    }

    function isOwner(address src) internal view returns (bool) {
        return bool(src == owner);
    }

    modifier auth {
        require(isAuthorized(msg.sender, msg.sig), "ds-auth-unauthorized");
        _;
    }

    function isAuthorized(address src, bytes4 sig) internal view returns (bool) {
        if (src == address(this)) {
            return true;
        } else if (src == owner) {
            return true;
        } else if (authority == DSAuthority(0)) {
            return false;
        } else {
            return authority.canCall(src, address(this), sig);
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/utility/Utils.sol

pragma solidity ^0.5.2;

/*
    Utilities & Common Modifiers
*/
contract Utils {
    modifier validAddress(address _address) {
        require(_address != address(0), "ValidAddress: address invalid.");
        _;
    }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/storage/interfaces/IDToken.sol

pragma solidity ^0.5.2;

interface IDToken {
  function mint(address _dst, uint256 _pie) external;

  function redeem(address _src, uint256 _wad) external;

  function redeemUnderlying(address _src, uint256 _pie) external;

  function getBaseData()
    external
    returns (
      uint256,
      uint256,
      uint256,
      uint256,
      uint256
    );

  function getHandlerInfo()
    external
    view
    returns (
      address[] memory,
      uint256[] memory,
      uint256[] memory
    );
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/storage/interfaces/IDTokenController.sol

pragma solidity ^0.5.2;

interface IDTokenController {
  function getDToken(address _token) external view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/token/interfaces/IERC20Token.sol

pragma solidity ^0.5.2;

/*
    ERC20 Standard Token interface
*/
contract IERC20Token {
    function balanceOf(address _owner) public view returns (uint);
    function allowance(address _owner, address _spender) public view returns (uint);
    function transfer(address _to, uint _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint _value) public returns (bool success);
    function approve(address _spender, uint _value) public returns (bool success);
    function totalSupply() public view returns (uint);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/token/interfaces/IDSWrappedToken.sol

pragma solidity ^0.5.2;

contract IDSWrappedToken is IERC20Token {
    function mint(address _account, uint _value) public;
    function burn(address _account, uint _value) public;
    function wrap(address _dst, uint _amount) public returns (uint);
    function unwrap(address _dst, uint _amount) public returns (uint);
    function changeByMultiple(uint _amount) public view returns (uint);
    function reverseByMultiple(uint _xAmount) public view returns (uint);
    function getSrcERC20() public view returns (address);
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/storage/DFPoolV2.sol

pragma solidity ^0.5.2;







contract DFPoolV1 is DSMath, DSAuth, Utils, ERC20SafeTransfer {
    address dfcol;

    constructor(address _dfcol) public {
        dfcol = _dfcol;
    }

    function transferFromSender(
        address _tokenID,
        address _from,
        uint256 _amount
    ) public auth returns (bool) {
        uint256 _balance = IERC20(_tokenID).balanceOf(address(this));
        require(
            doTransferFrom(_tokenID, _from, address(this), _amount),
            "transferFromSender: failed"
        );
        assert(
            sub(IERC20(_tokenID).balanceOf(address(this)), _balance) == _amount
        );
        return true;
    }

    function transferOut(
        address _tokenID,
        address _to,
        uint256 _amount
    ) public validAddress(_to) auth returns (bool) {
        uint256 _balance = IERC20(_tokenID).balanceOf(_to);
        require(doTransferOut(_tokenID, _to, _amount), "transferOut: failed");
        assert(sub(IERC20(_tokenID).balanceOf(_to), _balance) == _amount);
        return true;
    }

    function transferToCol(address _tokenID, uint256 _amount)
        public
        auth
        returns (bool)
    {
        require(
            dfcol != address(0),
            "TransferToCol: collateral address empty."
        );
        uint256 _balance = IERC20(_tokenID).balanceOf(dfcol);
        require(
            doTransferOut(_tokenID, dfcol, _amount),
            "transferToCol: failed"
        );
        assert(sub(IERC20(_tokenID).balanceOf(dfcol), _balance) == _amount);
        return true;
    }

    function transferFromSenderToCol(
        address _tokenID,
        address _from,
        uint256 _amount
    ) public auth returns (bool) {
        require(
            dfcol != address(0),
            "TransferFromSenderToCol: collateral address empty."
        );
        uint256 _balance = IERC20(_tokenID).balanceOf(dfcol);
        require(
            doTransferFrom(_tokenID, _from, dfcol, _amount),
            "transferFromSenderToCol: failed"
        );
        assert(sub(IERC20(_tokenID).balanceOf(dfcol), _balance) == _amount);
        return true;
    }

    function approveToEngine(address _tokenIdx, address _engineAddress)
        public
        auth
    {
        require(
            doApprove(_tokenIdx, _engineAddress, uint256(-1)),
            "approveToEngine: Approve failed!"
        );
    }
}

contract DFPoolV2 is ERC20SafeTransfer, DFPoolV1(address(0)) {
    bool private initialized;
    address dFPoolOld;
    address dTokenController;

    constructor(
        address _dfcol,
        address _dFPoolOld,
        address _dTokenController
    ) public {
        initialize(_dfcol, _dFPoolOld, _dTokenController);
    }

    // --- Init ---
    function initialize(
        address _dfcol,
        address _dFPoolOld,
        address _dTokenController
    ) public {
        require(!initialized, "initialize: Already initialized!");
        owner = msg.sender;
        dfcol = _dfcol;
        dFPoolOld = _dFPoolOld;
        dTokenController = _dTokenController;
        initialized = true;
    }

    function transferFromSenderOneClick(
        address _tokenID,
        address _from,
        uint256 _amount
    ) public returns (bool) {
        super.transferFromSender(_tokenID, _from, _amount);
        IDToken(IDTokenController(dTokenController).getDToken(_tokenID)).mint(
            address(this),
            _amount
        );
        return true;
    }

    function transferOutSrc(
        address _tokenID,
        address _to,
        uint256 _amount
    ) public returns (bool) {
        IDToken(IDTokenController(dTokenController).getDToken(_tokenID))
            .redeemUnderlying(address(this), _amount);
        transferOut(_tokenID, _to, _amount);
        return true;
    }

    function transferToCol(address _tokenID, uint256 _amount)
        public
        returns (bool)
    {
        super.transferToCol(_tokenID, _amount);
        address _srcToken = IDSWrappedToken(_tokenID).getSrcERC20();
        IDToken(IDTokenController(dTokenController).getDToken(_srcToken)).mint(
            address(this),
            IDSWrappedToken(_tokenID).reverseByMultiple(_amount)
        );
        return true;
    }

    function migrateOldPool(address[] calldata _tokens, address _usdx)
        external
        auth
    {
        address _dFPoolOld = dFPoolOld;
        address _dfcol = dfcol;
        address _dTokenController = dTokenController;
        address _srcToken;
        uint256 _amount;
        uint256 _balance;
        for (uint256 i = 0; i < _tokens.length; i++) {
            // transfer pending wrapped token to new pool
            _amount = IERC20(_tokens[i]).balanceOf(_dFPoolOld);
            if (_amount > 0)
                DFPoolV1(_dFPoolOld).transferOut(
                    _tokens[i],
                    address(this),
                    _amount
                );

            // transfer all src token to new pool
            _srcToken = IDSWrappedToken(_tokens[i]).getSrcERC20();
            _amount = IERC20(_srcToken).balanceOf(_dFPoolOld);
            _balance = IERC20(_srcToken).balanceOf(address(this));
            if (_amount > 0)
                DFPoolV1(_dFPoolOld).transferOut(
                    _srcToken,
                    address(this),
                    _amount
                );
            require(
                add(_balance, _amount) ==
                    IERC20(_srcToken).balanceOf(address(this)),
                "migrateOldPool: Transfer src token to new pool verification failed"
            );

            // mint collateral token into dToken
            _amount = IERC20(_tokens[i]).balanceOf(_dfcol);
            if (_amount > 0)
                IDToken(
                    IDTokenController(_dTokenController).getDToken(_srcToken)
                )
                    .mint(
                    address(this),
                    IDSWrappedToken(_tokens[i]).reverseByMultiple(_amount)
                );
            require(
                IDSWrappedToken(_tokens[i]).reverseByMultiple(
                    IERC20(_tokens[i]).balanceOf(address(this))
                ) == IERC20(_srcToken).balanceOf(address(this)),
                "migrateOldPool: Pending src token in new pool verification failed"
            );
        }

        // transfer claimable USDx to new pool
        _amount = IERC20(_usdx).balanceOf(_dFPoolOld);
        if (_amount > 0)
            DFPoolV1(_dFPoolOld).transferOut(_usdx, address(this), _amount);
    }

    function approve(address _tokenID) external auth {
        address _dToken = IDTokenController(dTokenController).getDToken(
            _tokenID
        );
        require(_dToken != address(0), "approve: dToekn address empty.");
        require(
            doApprove(_tokenID, _dToken, uint256(-1)),
            "approve: Approve failed!"
        );
    }

    function rmul(uint256 x, uint256 y) internal pure returns (uint256 z) {
        z = mul(x, y) / 1e18;
    }

    function getInterestByXToken(address _xToken) public returns (address, uint256) {

        address _token = IDSWrappedToken(_xToken).getSrcERC20();
        uint256 _xBalance = IDSWrappedToken(_xToken).changeByMultiple(getUnderlying(_token)); 
        uint256 _xPrincipal = IERC20(_xToken).balanceOf(dfcol);
        return (_token, _xBalance > _xPrincipal ? sub(_xBalance, _xPrincipal) : 0);
    }

    function getUnderlying(address _underlying) public returns (uint256) {
        address _dToken = IDTokenController(dTokenController).getDToken(_underlying);
        if (_dToken == address(0))
            return 0;

        (, uint256 _exchangeRate, , uint256 _feeRate,) = IDToken(_dToken).getBaseData();

        uint256 _grossAmount = rmul(IERC20(_dToken).balanceOf(address(this)), _exchangeRate);
        return rmul(_grossAmount, sub(1e18, _feeRate));
    }
}
