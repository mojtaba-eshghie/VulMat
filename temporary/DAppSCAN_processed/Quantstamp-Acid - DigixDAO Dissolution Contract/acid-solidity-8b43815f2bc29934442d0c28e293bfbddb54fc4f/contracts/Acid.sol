// File: ../sc_datasets/DAppSCAN/Quantstamp-Acid - DigixDAO Dissolution Contract/acid-solidity-8b43815f2bc29934442d0c28e293bfbddb54fc4f/contracts/DGDInterface.sol

pragma solidity 0.5.16;

contract DGDInterface {

  string public constant name = "DigixDAO";
  string public constant symbol = "DGD";
  uint8 public constant decimals = 9;  

  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
  event Transfer(address indexed from, address indexed to, uint tokens);

  mapping(address => uint256) balances;

  mapping(address => mapping (address => uint256)) allowed;
    
  uint256 public totalSupply;

  constructor() public {  
    totalSupply = 2000000000000000;
  	balances[msg.sender] = totalSupply;
  }  

  function balanceOf(address tokenOwner) public view returns (uint) {
    return balances[tokenOwner];
  }

  function transfer(address receiver, uint numTokens) public returns (bool) {
    require(numTokens <= balances[msg.sender]);
    balances[msg.sender] = balances[msg.sender] - numTokens;
    balances[receiver] = balances[receiver] + numTokens;
    emit Transfer(msg.sender, receiver, numTokens);
    return true;
  }

  function approve(address delegate, uint numTokens) public returns (bool) {
    allowed[msg.sender][delegate] = numTokens;
    emit Approval(msg.sender, delegate, numTokens);
    return true;
  }

  function allowance(address owner, address delegate) public view returns (uint) {
    return allowed[owner][delegate];
  }

  function transferFrom(address owner, address buyer, uint numTokens) public returns (bool _success) {
    require(numTokens <= balances[owner]);    
    require(numTokens <= allowed[owner][msg.sender]);
   
    balances[owner] = balances[owner] - numTokens;
    allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens;
    balances[buyer] = balances[buyer] + numTokens;
    emit Transfer(owner, buyer, numTokens);
    _success = true;
  }
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Acid - DigixDAO Dissolution Contract/acid-solidity-8b43815f2bc29934442d0c28e293bfbddb54fc4f/contracts/Acid.sol

//SWC-Floating Pragma: L2
pragma solidity 0.5.16;

contract Acid {
  
  event Refund(address indexed user, uint256 indexed dgds, uint256 refundAmount);

  // wei refunded per 0.000000001 DGD burned
  uint256 public weiPerNanoDGD;
  bool public isInitialized;
  address public dgdTokenContract;
  address public owner;

  modifier onlyOwner() {
    require(owner == msg.sender);
    _;
  }

  modifier unlessInitialized() {
    require(!isInitialized, "contract is already initialized");
    _;
  }

  modifier requireInitialized() {
    require(isInitialized, "contract is not initialized");
    _;
  }

  constructor() public {
    owner = msg.sender;
    isInitialized = false;
  }

  function () external payable {}  

  function init(uint256 _weiPerNanoDGD, address _dgdTokenContract) public onlyOwner() unlessInitialized() returns (bool _success) {
    require(_weiPerNanoDGD > 0, "rate cannot be zero");
    require(_dgdTokenContract != address(0), "DGD token contract cannot be empty");
    weiPerNanoDGD = _weiPerNanoDGD;
    dgdTokenContract = _dgdTokenContract;
    isInitialized = true;
    _success = true;
  }
  //SWC-Integer Overflow and Underflow: L47-L59
  function burn() public requireInitialized() returns (bool _success) {
    // Rate will be calculated based on the nearest decimal
    uint256 _amount = DGDInterface(dgdTokenContract).balanceOf(msg.sender);
    uint256 _wei = mul(_amount, weiPerNanoDGD);
    require(address(this).balance >= _wei, "Contract does not have enough funds");
    require(DGDInterface(dgdTokenContract).transferFrom(msg.sender, 0x0000000000000000000000000000000000000000, _amount), "No DGDs or DGD account not authorized");
    address _user = msg.sender;
    //SWC-Unchecked Call Return Value: L56
    //SWC-DoS with Failed Call: L56
    (_success,) = _user.call.value(_wei)('');
    require(_success, "Transfer of Ether failed");
    emit Refund(_user, _amount, _wei);
  }

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");

    return c;
  }
}
