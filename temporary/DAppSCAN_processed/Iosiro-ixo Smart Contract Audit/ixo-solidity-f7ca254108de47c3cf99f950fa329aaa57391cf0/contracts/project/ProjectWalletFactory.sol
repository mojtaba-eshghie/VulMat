// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-f7ca254108de47c3cf99f950fa329aaa57391cf0/contracts/project/ProjectWallet.sol

pragma solidity ^0.4.24;

contract ProjectWallet {

    function transfer(address _receiver, uint256 _amt) public returns (bool);

}

// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-f7ca254108de47c3cf99f950fa329aaa57391cf0/contracts/token/ERC20.sol

pragma solidity ^0.4.24;

contract ERC20 {
    function totalSupply() public view returns (uint256);

    function balanceOf(address _who) public view returns (uint256);

    function allowance(address _owner, address _spender) public view returns (uint256);

    function transfer(address _to, uint256 _value) public returns (bool);

    function approve(address _spender, uint256 _value) public returns (bool);

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool);

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-f7ca254108de47c3cf99f950fa329aaa57391cf0/contracts/project/BasicProjectWallet.sol

pragma solidity ^0.4.24;


contract BasicProjectWallet is ProjectWallet {

    address private token;
    address private authoriser;
    bytes32 public name;

  /**
   * @dev Constructor
   * @param _token address The ixo token address
   * @param _authoriser address The address of the contract that
   * @param _name bytes32 The project name
   */
    constructor(address _token, address _authoriser, bytes32 _name) public {
        token = _token;
        authoriser = _authoriser;
        name = _name;
    }

    /**
    * @dev Throws if called by any account other than the authoriser.
    */
    modifier onlyAuthoriser() {
        require(msg.sender == authoriser, "Permission denied");
        _;
    }

  /**
   * @dev Transfer tokens to the receiver
   * @param _receiver The address which will receive the funds.
   * @param _amt The amount of tokens to transfer.
   */
    function transfer(
        address _receiver,
        uint256 _amt
    )
    public onlyAuthoriser
    returns (bool)
    {
        ERC20(token).transfer(_receiver, _amt);
    }

}

// File: ../sc_datasets/DAppSCAN/Iosiro-ixo Smart Contract Audit/ixo-solidity-f7ca254108de47c3cf99f950fa329aaa57391cf0/contracts/project/ProjectWalletFactory.sol

pragma solidity ^0.4.24;

contract ProjectWalletFactory {

  /**
   * @dev Create a new wallet
   * @param _token address The ixo token address
   * @param _authoriser address The address of the contract that
   * @param _name bytes32 The project did
   */
    function createWallet(address _token, address _authoriser, bytes32 _name) public returns (address) {
        require(_name[0] != 0, "Invalid name");
        address wallet = new BasicProjectWallet(_token, _authoriser, _name);
        return wallet;
    }
}
