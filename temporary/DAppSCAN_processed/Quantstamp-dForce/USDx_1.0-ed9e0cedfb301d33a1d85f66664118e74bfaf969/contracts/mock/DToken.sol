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

// File: ../sc_datasets/DAppSCAN/Quantstamp-dForce/USDx_1.0-ed9e0cedfb301d33a1d85f66664118e74bfaf969/contracts/mock/DToken.sol

pragma solidity ^0.5.2;


contract DToken is ERC20SafeTransfer, DSMath {
  // --- Data ---
  bool private initialized; // Flag of initialize data

  address public token;

  // --- ERC20 Data ---
  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;

  uint256 public constant BASE = 10**18;

  mapping(address => uint256) public balances;
  mapping(address => mapping(address => uint256)) public allowance;

  /**
   * The constructor is used here to ensure that the implementation
   * contract is initialized. An uncontrolled implementation
   * contract might lead to misleading state
   * for users who accidentally interact with it.
   */
  constructor(
    string memory _name,
    string memory _symbol,
    address _token
  ) public {
    initialize(_name, _symbol, _token);
  }

  // --- Init ---
  function initialize(
    string memory _name,
    string memory _symbol,
    address _token
  ) public {
    require(!initialized, "initialize: Already initialized!");
    name = _name;
    symbol = _symbol;
    token = _token;
    decimals = IERC20(_token).decimals();
    initialized = true;
  }

  /**
   * @dev Deposit token to earn savings, but only when the contract is not paused.
   * @param _dst Account who will get dToken.
   * @param _pie Amount to deposit, scaled by 1e18.
   */
  function mint(address _dst, uint256 _pie) external {
    uint256 amount = rdiv(_pie, getExchangeRate());

    // Transfer the calculated token amount from `msg.sender` to the `handler`.
    require(
      doTransferFrom(token, msg.sender, address(this), _pie),
      "mint: transfer token failed."
    );

    balances[_dst] = add(balances[_dst], amount);
    totalSupply = add(totalSupply, amount);
  }

  /**
   * @dev Redeem specific amount of underlying token, but only when the contract is not paused.
   * @param _src Account who will spend dToken.
   * @param _pie Amount to redeem, scaled by 1e18.
   */
  function redeemUnderlying(address _src, uint256 _pie) external {
    uint256 amount = rdivup(_pie, getExchangeRate());

    // Check the balance and allowance
    uint256 _balance = balances[_src];
    require(_balance >= amount, "redeemUnderlying: insufficient balance");
    if (_src != msg.sender && allowance[_src][msg.sender] != uint256(-1)) {
      require(
        allowance[_src][msg.sender] >= amount,
        "redeemUnderlying: insufficient allowance"
      );
      allowance[_src][msg.sender] = sub(allowance[_src][msg.sender], amount);
    }

    // Update the balance and totalSupply
    balances[_src] = sub(balances[_src], amount);
    totalSupply = sub(totalSupply, amount);

    require(
      doTransferOut(token, msg.sender, _pie),
      "redeemUnderlying: transfer failed"
    );
  }

  // --- ERC20 Standard Interfaces ---
  function transfer(address _dst, uint256 _wad) external returns (bool) {
    return transferFrom(msg.sender, _dst, _wad);
  }

  function transferFrom(
    address _src,
    address _dst,
    uint256 _wad
  ) public returns (bool) {
    // Check balance and allowance
    require(balances[_src] >= _wad, "transferFrom: insufficient balance");
    if (_src != msg.sender && allowance[_src][msg.sender] != uint256(-1)) {
      require(
        allowance[_src][msg.sender] >= _wad,
        "transferFrom: insufficient allowance"
      );
      allowance[_src][msg.sender] = sub(allowance[_src][msg.sender], _wad);
    }

    balances[_src] = sub(balances[_src], _wad);
    balances[_dst] = add(balances[_dst], _wad);

    return true;
  }

  function approve(address _spender, uint256 _wad) public returns (bool) {
    allowance[msg.sender][_spender] = _wad;
    return true;
  }

  function balanceOf(address account) public view returns (uint256) {
    return balances[account];
  }

  function getTotalBalance() public view returns (uint256) {
    return IERC20(token).balanceOf(address(this));
  }

  function getTokenBalance(address account) public view returns (uint256) {
    return rmul(balanceOf(account), getExchangeRate());
  }

  function getExchangeRate() public view returns (uint256) {
    uint256 _totalSupply = totalSupply;
    return _totalSupply > 0 ? rdiv(getTotalBalance(), _totalSupply) : BASE;
  }

  function getBaseData()
    external
    returns (
      uint256,
      uint256,
      uint256,
      uint256,
      uint256
    )
  {
    return (decimals, getExchangeRate(), 0, 0, 0);
  }

  function rmul(uint256 x, uint256 y) internal pure returns (uint256 z) {
    z = mul(x, y) / BASE;
  }

  function rdiv(uint256 x, uint256 y) internal pure returns (uint256 z) {
    z = mul(x, BASE) / y;
  }

  function rdivup(uint256 x, uint256 y) internal pure returns (uint256 z) {
    z = add(mul(x, BASE), sub(y, 1)) / y;
  }
}
