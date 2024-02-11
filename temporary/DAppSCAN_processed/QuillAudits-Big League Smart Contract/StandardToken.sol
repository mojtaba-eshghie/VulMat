// File: ../sc_datasets/DAppSCAN/QuillAudits-Big League Smart Contract/StandardToken.sol

/**
 *Submitted for verification at BscScan.com on 2021-08-13
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.5;

contract Ownable {
    address public owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    constructor() {
        owner = msg.sender;
    }
}

contract Pausable is Ownable {
    event Pause();
    event Unpause();

    bool public paused = false;

    modifier whenNotPaused() {
        require(!paused);
        _;
    }

    modifier whenPaused() {
        require(paused);
        _;
    }
    
    function pause() onlyOwner whenNotPaused public {
        paused = true;
        emit Pause();
    }

    function unpause() onlyOwner whenPaused public {
        paused = false;
        emit Unpause();
    }
}

interface IBEP20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}
interface IDEXFactory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}
interface IDEXRouter {
    function factory() external pure returns (address);
    function addLiquidityETH(address token, uint256 amountTokenDesired, uint256 amountTokenMin, uint256 amountETHMin, address to, uint256 deadline) external payable returns (uint256 amountToken, uint256 amountETH, uint256 liquidity);
    function swapExactTokensForETHSupportingFeeOnTransferTokens(uint256 amountIn, uint256 amountOutMin, address[] calldata path, address to, uint256 deadline) external;
}

contract StandardToken is Ownable, Pausable {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => mapping(address => uint256)) public allowance;
    mapping(address => uint256) public balanceOf;

    address holdersWallet;
    address public pair;
    IDEXRouter public router;
    address public WBNB = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c; //change


    struct FeeSettings {
        uint256 liquidity;
        uint256 holders;
        uint256 burn;
        uint256 total;
        uint256 _denominator;
    }
    
    FeeSettings public fees = FeeSettings({
        liquidity: 0,
        holders: 3,
        burn: 2,
        total: 3,
        _denominator: 100
    });

    mapping(address => bool) public isPair;

    uint256[2] public _SWAPBACK_THRESHOLD = [1, 10000]; // 0.01% of current supply
    bool public MINT_FORBIDDEN = false;
    bool inSwap;
    modifier swapping() {
        inSwap = true;
        _;
        inSwap = false;
    }

    mapping(address => bool) public tokenBlacklist;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed burner, uint256 value);
    event Blacklist(address indexed blackListed, bool value);
    event Pair(address indexed excluded, bool value);
    
    receive() external payable {}

    function transfer(address _to, uint256 _value) public whenNotPaused returns (bool) {
        require(!tokenBlacklist[msg.sender]);
        require(_to != address(0));
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public whenNotPaused returns (bool) {
        require(!tokenBlacklist[msg.sender]);
        require(_to != address(0));
        if (allowance[_from][msg.sender] < ~uint256(0)) allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        uint256 tempValue = _value;
        // bool _noFee = isFeeExempt[_from] || isFeeExempt[_to] || inSwap || _to == address(router);
        bool _fee = isPair[_to];
        if (_fee) {
            tempValue -= _substractBurn(_from, _value);
            tempValue -= _substractFees(_from, _value);
            _sellAndDistributeAccumulatedTKNFee();
        }
        balanceOf[_from] -= tempValue;
        balanceOf[_to] += tempValue;
        emit Transfer(_from, _to, tempValue);
    }


    function _substractBurn(address _sender, uint256 _value) internal returns (uint256 amount) {
        if (fees.burn == 0) return 0;
        amount = (_value * fees.burn) / fees._denominator;
        balanceOf[_sender] -= amount;
        totalSupply -= amount;
		emit Transfer(_sender, address(0), amount);
    }

    function _substractFees(address _sender, uint256 _value) internal returns (uint256 amount) {
        if (fees.total == 0) return 0;
        amount = (_value * fees.total) / fees._denominator;
        balanceOf[_sender] -= amount;
        balanceOf[address(this)] += amount;
		emit Transfer(_sender, address(this), amount);
    }
//SWC-DoS with Failed Call：L167
    function _sellAndDistributeAccumulatedTKNFee() internal swapping {
        uint256 _amount = ((totalSupply * _SWAPBACK_THRESHOLD[0]) / _SWAPBACK_THRESHOLD[1]);
        if (balanceOf[address(this)] < _amount) return;

        uint256 holdersFee = (_amount * fees.holders) / fees.total;
        _transfer(address(this), holdersWallet, holdersFee);

        uint256 halfLiquidityFee = fees.liquidity / 2;
        uint256 TKNtoLiquidity = (_amount * halfLiquidityFee) / fees.total;
        uint256 amountToSwap = _amount - holdersFee - TKNtoLiquidity;

        if (amountToSwap > 0) {
            address[] memory path = new address[](2);
            path[0] = address(this);
            path[1] = WBNB;
            router.swapExactTokensForETHSupportingFeeOnTransferTokens(amountToSwap, 0, path, address(this), block.timestamp);

        } else return;

        uint256 _gotBNB = address(this).balance;
        uint256 BNBtoLiquidity = _gotBNB;

        if (BNBtoLiquidity > 0) {
            router.addLiquidityETH{value: BNBtoLiquidity}(address(this), TKNtoLiquidity, 0, 0, owner, block.timestamp);
        }
    }

    function approve(address _spender, uint256 _value) public whenNotPaused returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function increaseApproval(address _spender, uint _value) public whenNotPaused returns (bool) {
        allowance[msg.sender][_spender] += _value;
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }

    function decreaseApproval(address _spender, uint _value) public whenNotPaused returns (bool) {
        if (_value >= allowance[msg.sender][_spender]) allowance[msg.sender][_spender] = 0;
        else allowance[msg.sender][_spender] -= _value;
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]);
        return true;
    }

	function burn(uint256 _value) onlyOwner public {
		balanceOf[msg.sender] -= _value;
		totalSupply -= _value;
		emit Burn(msg.sender, _value);
		emit Transfer(msg.sender, address(0), _value);
	}
    function mint(address _who, uint256 _value) onlyOwner public {
        require(!MINT_FORBIDDEN, "mint is forbidden forever. sorry");
        balanceOf[_who] += _value;
        totalSupply += _value;
        emit Mint(address(0), _who, _value);
        emit Transfer(address(0), _who, _value);
    }
    function forbidMint() onlyOwner public {
        MINT_FORBIDDEN = true;
    }
    function setBlacklisted(address _address,  bool _isBlackListed) public onlyOwner {
        require(tokenBlacklist[_address] != _isBlackListed);
        tokenBlacklist[_address] = _isBlackListed;
        emit Blacklist(_address, _isBlackListed);
    }
    function setPair(address _address,  bool _isExcluded) public onlyOwner  {
        require(isPair[_address] != _isExcluded);
        isPair[_address] = _isExcluded;
        emit Pair(_address, _isExcluded);
    }
	function setFees(uint256 _liquidity, uint256 _holders, uint256 _burn, uint256 _denominator) onlyOwner public {
        uint256 _total = _liquidity + _holders;
        require (_total + _burn <= _denominator);
        fees = FeeSettings(_liquidity, _holders, _burn, _total, _denominator);
	}
    function setHoldersWallet(address _holdersWallet) onlyOwner public {
        holdersWallet = _holdersWallet;
	}
    function setLiquifyThreshold(uint256 _numerator, uint256 _denominator) public onlyOwner {
        _SWAPBACK_THRESHOLD = [_numerator, _denominator];
    }
    function setRouter(IDEXRouter _address) public onlyOwner {
        router = _address;
        allowance[address(this)][address(router)] = ~uint256(0);
        emit Approval(address(this), address(router), ~uint256(0));
    }
    function setPair(address _address) public onlyOwner {
        pair = _address;
    }

    constructor(address _owner) {

        name = 'Big League';
        symbol = 'BGLG';

        decimals = 18;
        totalSupply = 125 * 1e6 * 1e18;

        owner = _owner;

        balanceOf[owner] = totalSupply;
        emit Transfer(address(0), owner, totalSupply);
        
        holdersWallet = 0x828Ab75e87Bb5B249186c2Fe0D3bAd821a119b44; // change (holders wallet)
        router = IDEXRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E); //change ()

        allowance[address(this)][address(router)] = ~uint256(0);
        emit Approval(address(this), address(router), ~uint256(0));

        pair = IDEXFactory(router.factory()).createPair(WBNB, address(this));
        isPair[address(pair)] = true;
    }   
    
}
