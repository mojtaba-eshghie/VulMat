// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyWeightedVoteContract.sol

pragma solidity ^0.4.24;

contract ITwoKeyWeightedVoteContract {
    function getDescription() public view returns(string);
    function transferSig(bytes sig) public returns (address[]);
    function setValid() public;
    function getDynamicData() public view returns (uint,uint,uint,uint,uint,uint);
    function getHowMuchAddressPutPower(address add) public view returns (uint);
    function getVoteAndChoicePerAddress(address voter) public view returns (bool, uint);
    function getAllVoters() public view returns (address[]);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/ITwoKeyRegistry.sol

pragma solidity ^0.4.24;

contract ITwoKeyRegistry {
    function checkIfUserExists(address _userAddress) public view returns (bool);
    function getUserData(address _user) public view returns (bytes32,bytes32,bytes32);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/math/SafeMath.sol

pragma solidity ^0.4.24;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 _a, uint256 _b) internal pure returns (uint256 c) {
    // Gas optimization: this is cheaper than asserting 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
    if (_a == 0) {
      return 0;
    }

    c = _a * _b;
    assert(c / _a == _b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 _a, uint256 _b) internal pure returns (uint256) {
    // assert(_b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = _a / _b;
    // assert(_a == _b * c + _a % _b); // There is no case in which this doesn't hold
    return _a / _b;
  }

  /**
  * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 _a, uint256 _b) internal pure returns (uint256) {
    assert(_b <= _a);
    return _a - _b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 _a, uint256 _b) internal pure returns (uint256 c) {
    c = _a + _b;
    assert(c >= _a);
    return c;
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol

pragma solidity ^0.4.24;


/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * See https://github.com/ethereum/EIPs/issues/179
 */
contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address _who) public view returns (uint256);
  function transfer(address _to, uint256 _value) public returns (bool);
  function allowance(address _ocwner, address _spender) public view returns (uint256);
  function approve(address spender, uint tokens) public returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool);

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol

pragma solidity ^0.4.24;


/**
 * @title Standard ERC20 token
 *
 * @dev Implementation of the basic standard token.
 * https://github.com/ethereum/EIPs/issues/20
 * Based on code by FirstBlood: https://github.com/Firstbloodio/token/blob/master/smart_contract/FirstBloodToken.sol
 */
contract StandardToken is ERC20Basic {

  using SafeMath for uint256;

  uint256 internal totalSupply_;
  string public name;
  string public symbol;
  uint8 public decimals;

  mapping (address => mapping (address => uint256)) internal allowed;
  mapping(address => uint256) internal balances;


  /**
   * @dev Transfer tokens from one address to another
   * @param _from address The address which you want to send tokens from
   * @param _to address The address which you want to transfer to
   * @param _value uint256 the amount of tokens to be transferred
   */
  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  )
    public
    returns (bool)
  {
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    require(_to != address(0));

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    return true;
  }

  /**
   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
   * Beware that changing an allowance with this method brings the risk that someone may use both the old
   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   * @param _spender The address which will spend the funds.
   * @param _value The amount of tokens to be spent.
   */
  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  /**
   * @dev Function to check the amount of tokens that an owner allowed to a spender.
   * @param _owner address The address which owns the funds.
   * @param _spender address The address which will spend the funds.
   * @return A uint256 specifying the amount of tokens still available for the spender.
   */
  function allowance(
    address _owner,
    address _spender
   )
    public
    view
    returns (uint256)
  {
    return allowed[_owner][_spender];
  }

  /**
   * @dev Increase the amount of tokens that an owner allowed to a spender.
   * approve should be called when allowed[_spender] == 0. To increment
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _addedValue The amount of tokens to increase the allowance by.
   */
  function increaseApproval(
    address _spender,
    uint256 _addedValue
  )
    public
    returns (bool)
  {
    allowed[msg.sender][_spender] = (
      allowed[msg.sender][_spender].add(_addedValue));
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
   * @dev Decrease the amount of tokens that an owner allowed to a spender.
   * approve should be called when allowed[_spender] == 0. To decrement
   * allowed value is better to use this function to avoid 2 calls (and wait until
   * the first transaction is mined)
   * From MonolithDAO Token.sol
   * @param _spender The address which will spend the funds.
   * @param _subtractedValue The amount of tokens to decrease the allowance by.
   */
  function decreaseApproval(
    address _spender,
    uint256 _subtractedValue
  )
    public
    returns (bool)
  {
    uint256 oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue >= oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  /**
  * @dev Total number of tokens in existence
  */
  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  /**
  * @dev Transfer token for a specified address
  * @param _to The address to transfer to.
  * @param _value The amount to be transferred.
  */
  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_value <= balances[msg.sender]);
    require(_to != address(0));

    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  /**
  * @dev Gets the balance of the specified address.
  * @param _owner The address to query the the balance of.
  * @return An uint256 representing the amount owned by the passed address.
  */
  function balanceOf(address _owner) public view returns (uint256) {
    return balances[_owner];
  }

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol

pragma solidity ^0.4.24;

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {

}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/ownership/Ownable.sol

pragma solidity ^0.4.24;


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;


  event OwnershipRenounced(address indexed previousOwner);
  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   * @notice Renouncing to ownership will leave the contract without an owner.
   * It will not be possible to call the functions with the `onlyOwner`
   * modifier anymore.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function transferOwnership(address _newOwner) public onlyOwner {
    _transferOwnership(_newOwner);
  }

  /**
   * @dev Transfers control of the contract to a newOwner.
   * @param _newOwner The address to transfer ownership to.
   */
  function _transferOwnership(address _newOwner) internal {
    require(_newOwner != address(0));
    emit OwnershipTransferred(owner, _newOwner);
    owner = _newOwner;
  }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/interfaces/IDecentralizedNation.sol

pragma solidity ^0.4.24;

contract IDecentralizedNation {

    function getMembersVotingPoints(
        address _memberAddress
    )
    public
    view
    returns (uint);


    function getMemberid(
        address _member
    )
    public
    view
    returns (uint);
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/libraries/GetCode.sol

pragma solidity ^0.4.24;

/// The following example provides library code to access the code of another contract and load it into a bytes variable.
/// This is not possible at all with “plain Solidity" and the idea is that assembly libraries will be used to enhance the
/// language in such ways.

/// Took from Solidity official documentation
/// https://solidity.readthedocs.io/en/latest/assembly.html?highlight=getCode
library GetCode {
    function at(address _addr) internal view returns (bytes o_code) {
        assembly {
        // retrieve the size of the code, this needs assembly
            let size := extcodesize(_addr)
        // allocate output byte array - this could also be done without assembly
        // by using o_code = new bytes(size)
            o_code := mload(0x40)
        // new "memory end" including padding
            mstore(0x40, add(o_code, and(add(add(size, 0x20), 0x1f), not(0x1f))))
        // store length in memory
            mstore(o_code, size)
        // actually retrieve the code, this needs assembly
            extcodecopy(_addr, add(o_code, 0x20), 0, size)
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/TwoKeyVoteToken.sol

pragma solidity ^0.4.24;




contract TwoKeyVoteToken is StandardToken, Ownable {
    using SafeMath for uint256;

    mapping (address => mapping (address => uint256)) internal allowed;
    mapping(address => uint256) internal balances;

    string public name = 'TwoKeyVote';
    string public symbol = '2KV';
    uint8 public decimals = 18;

    address public decentralizedNation;

    constructor(address _decentralizedNation) Ownable() public {
        require(_decentralizedNation!= address(0));
        decentralizedNation = _decentralizedNation;
    }

    mapping(address => bool) private visited;
    ///Mapping contract bytecode to boolean if is allowed to transfer tokens
    mapping(bytes32 => bool) private canEmit;

    /// @notice function where admin or any authorized person (will be added if needed) can add more contracts to allow them call methods
    /// @param _contractAddress is actually the address of contract we'd like to allow
    /// @dev We first fetch bytes32 contract code and then update our mapping
    /// @dev only admin can call this or an authorized person
    function addContract(address _contractAddress) public onlyOwner {
        require(_contractAddress != address(0), 'addContract zero');
        bytes memory _contractCode = GetCode.at(_contractAddress);
        bytes32 cc = keccak256(abi.encodePacked(_contractCode));
        canEmit[cc] = true;
    }


    ///@notice Modifier which will only allow allowed contracts to transfer tokens
    function allowedContract() private view returns (bool) {
        //just to use contract code instead of msg.sender address
        bytes memory code = GetCode.at(msg.sender);
        bytes32 cc = keccak256(abi.encodePacked(code));
        return canEmit[cc];
        return true;
    }

    modifier onlyAllowedContracts {
        require(allowedContract(), 'onlyAllowedContracts');
        _;
    }


    /**
    * @dev Gets the balance of the specified address.
    * @param _owner The address to query the the balance of.
    * @return An uint256 representing the amount owned by the passed address.
    */
    /*

    */
    function balanceOf(address _owner) public view returns (uint256) {
        if (visited[_owner]) {
            return balances[_owner];
        } else {
            uint id = IDecentralizedNation(decentralizedNation).getMemberid(_owner);
            if(id != 0) {
                uint balance = IDecentralizedNation(decentralizedNation).getMembersVotingPoints(_owner);
                return balance;
            } else {
                return 0;
            }
        }
    }

    function checkBalance(address _owner) internal returns (uint256){
        if (visited[_owner]) {
            return balances[_owner];
        }

        visited[_owner] = true;
        uint id = IDecentralizedNation(decentralizedNation).getMemberid(_owner);
        if(id != 0) {
             balances[_owner] = IDecentralizedNation(decentralizedNation).getMembersVotingPoints(_owner);
        }
        return balances[_owner];
    }

//    function balanceOf(address _owner) public view returns (uint256) {
//        uint balance = IDecentralizedNation(decentralizedNation).getMembersVotingPoints(_owner);
//        return balance;
//    }
//
//    function checkBalance(address _owner) public {
//        balances[_owner] = IDecentralizedNation(decentralizedNation).getMembersVotingPoints(_owner);
//    }
    /**
     * @dev Transfer tokens from one address to another
     * @param _from address The address which you want to send tokens from
     * @param _to address The address which you want to transfer to
     * @param _value uint256 the amount of tokens to be transferred
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    )
    public
//        onlyOwner
    returns (bool)
    {
        checkBalance(_from);
        uint balance = balanceOf(_from);
        require(_value <= balance, 'transferFrom balance');
        require(_to != address(0), 'transferFrom zero');
        //TODO : reduce balance on contract
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }


    /**
     * @dev Function to check the amount of tokens that an owner allowed to a spender.
     * @param _owner address The address which owns the funds.
     * @return A uint256 specifying the amount of tokens still available for the spender.
     */
    function allowance(
        address _owner,
        address _spender
    )
    public
    view
    returns (uint256)
    {
        return balanceOf(_owner);
    }



    /**
    * @dev Total number of tokens in existence
    */
    function totalSupply() public view returns (uint256) {
        revert("totalSupply - not supported");
        return 0;
    }

    /**
    * @dev Transfer token for a specified address
    */
    function transfer(address, uint256) public returns (bool) {
        revert("transfer - not supported");
        return false;
    }

    function approve(address, uint256) public returns (bool) {
        revert("approve - not supported");
        return false;
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/2key/DecentralizedNation.sol

pragma solidity ^0.4.24;



contract DecentralizedNation {

    string public nationName;
    string public ipfsForConstitution;
    string public ipfsHashForDAOPublicInfo;

    bytes32[] public memberTypes;

    address initialFounder;
    Member[] public members;
    uint numOfMembers;

    address public votingToken;

    bool initialized = false;

    mapping(address => uint) public memberId;

    mapping(bytes32 => uint) public limitOfMembersPerType;
    mapping(bytes32 => address[]) public memberTypeToMembers;

    mapping(address => Campaign) public votingContractToCampaign;


    Campaign[] public allCampaigns;
    uint numberOfVotingCamapignsAndPetitions;

    mapping(address => bytes32) public memberAddressToMemberType;

    mapping(address => uint) votingPoints;
    mapping(address => uint) totalNumberOfCampaigns;
    mapping(bytes32 => bool) public isMemberTypeEligibleToCreateVotingCampaign;

    uint minimalNumberOfPositiveVotersForVotingCampaign;
    uint minimalPercentOfVotersForVotingCampaign;

    uint minimalNumberOfVotersForPetitioningCampaign;
    uint minimalPercentOfVotersForPetitioningCampaign;

    function getLimitsForDAO() public view returns (uint,uint,uint,uint) {
        return(
            minimalNumberOfPositiveVotersForVotingCampaign,
            minimalPercentOfVotersForVotingCampaign,
            minimalNumberOfVotersForPetitioningCampaign,
            minimalPercentOfVotersForPetitioningCampaign
        );
    }

    address twoKeyRegistryContract;

    struct Campaign {
        string votingReason; //simple text to fulfill screen?
        bool finished;
        uint votesYes;
        uint votesNo;
        int votingResultForYes;
        int votingResultForNo;
        uint votingCampaignLengthInDays;
        bytes32 campaignType; //can be voting/petitioning
        address votingContract;
    }



    struct Member {
        address memberAddress;
        bytes32 username;
        bytes32 fullName;
        bytes32 email;
        bytes32 memberType;
    }




    modifier onlyMembers {
        require(memberId[msg.sender] != 0);
        _;
    }

    modifier onlyInitialFounder {
        require(msg.sender == initialFounder);
        _;
    }


    constructor(
        string _nationName,
        string _ipfsHashForConstitution,
        string _ipfsHashForDAOPublicInfo,
        address[] founder,
        bytes32[] initialMemberTypes,
        uint[] limitPerType,
        uint[] rightsToCreateVoting,
        uint _minimalNumberOfVotersForVotingCampaign,
        uint _minimalPercentOfVotersForVotingCampaign,
        uint _minimalNumberOfVotersForPetitioningCampaign,
        uint _minimalPercentOfVotersForPetitioningCampaign,
        address _twoKeyRegistry
    ) public {
        require(limitPerType.length == initialMemberTypes.length);
        initialFounder = founder[0];
        memberTypes.push(bytes32("FOUNDERS"));
        isMemberTypeEligibleToCreateVotingCampaign[bytes32("FOUNDERS")] = true;
        twoKeyRegistryContract = _twoKeyRegistry;
        addMember(0,bytes32(0));
        addMember(founder[0], bytes32("FOUNDERS"));

        votingToken = new TwoKeyVoteToken(address(this));

        for(uint j=0; j<initialMemberTypes.length; j++) {
            limitOfMembersPerType[initialMemberTypes[j]] = limitPerType[j];
            if(rightsToCreateVoting[j] == 1){
                isMemberTypeEligibleToCreateVotingCampaign[initialMemberTypes[j]] = true;
            } else {
                isMemberTypeEligibleToCreateVotingCampaign[initialMemberTypes[j]] = false;
            }
            memberTypes.push(initialMemberTypes[j]);
        }

        minimalNumberOfPositiveVotersForVotingCampaign = _minimalNumberOfVotersForVotingCampaign;
        minimalPercentOfVotersForVotingCampaign = _minimalPercentOfVotersForVotingCampaign;
        minimalNumberOfVotersForPetitioningCampaign = _minimalNumberOfVotersForPetitioningCampaign;
        minimalPercentOfVotersForPetitioningCampaign = _minimalPercentOfVotersForPetitioningCampaign;

        nationName = _nationName;
        ipfsForConstitution = _ipfsHashForConstitution;
        ipfsHashForDAOPublicInfo = _ipfsHashForDAOPublicInfo;
        initialized = true;
    }


    function addMembersByFounders(address _memberAddress, bytes32 _memberType) public onlyInitialFounder {
        require(limitOfMembersPerType[_memberType] > memberTypeToMembers[_memberType].length);

        bytes32 memberUsername;
        bytes32 memberFullName;
        bytes32 memberEmail;

        (memberUsername,memberFullName,memberEmail) = ITwoKeyRegistry(twoKeyRegistryContract).getUserData(_memberAddress);
        require(checkIfMemberTypeExists(_memberType) || _memberType == bytes32(0));
        Member memory m = Member({
            memberAddress: _memberAddress,
            username: memberUsername,
            fullName: memberFullName,
            email: memberEmail,
            memberType: _memberType
            });

        members.push(m);
        memberAddressToMemberType[_memberAddress] = _memberType;
        memberId[_memberAddress] = numOfMembers;
        memberTypeToMembers[_memberType].push(_memberAddress);
        votingPoints[_memberAddress] = 1000000000000000000;
        totalNumberOfCampaigns[_memberAddress] = numberOfVotingCamapignsAndPetitions;
        numOfMembers++;
    }

    function addMember(
        address _memberAddress,
        bytes32 _memberType)
    internal {
        if(members.length > 0) {
            require(ITwoKeyRegistry(twoKeyRegistryContract).checkIfUserExists(_memberAddress));
        }
        if(initialized) {
            require(limitOfMembersPerType[_memberType] > memberTypeToMembers[_memberType].length);
        }

        bytes32 memberUsername;
        bytes32 memberFullName;
        bytes32 memberEmail;

        (memberUsername,memberFullName,memberEmail) = ITwoKeyRegistry(twoKeyRegistryContract).getUserData(_memberAddress);
        require(checkIfMemberTypeExists(_memberType) || _memberType == bytes32(0));
        Member memory m = Member({
            memberAddress: _memberAddress,
            username: memberUsername,
            fullName: memberFullName,
            email: memberEmail,
            memberType: _memberType
        });

        members.push(m);
        memberAddressToMemberType[_memberAddress] = _memberType;
        memberId[_memberAddress] = numOfMembers;
        memberTypeToMembers[_memberType].push(_memberAddress);
        votingPoints[_memberAddress] = 1000000000000000000;
        totalNumberOfCampaigns[_memberAddress] = numberOfVotingCamapignsAndPetitions;
        numOfMembers++;
    }

    function removeMemberFromMemberTypeArray(address targetMember) internal {
        bytes32 memberType = memberAddressToMemberType[targetMember];
        bool flag = false;
        for(uint i=0; i<memberTypeToMembers[memberType].length - 1; i++) {
            if(memberTypeToMembers[memberType][i] == targetMember) {
                flag = true;
            }
            if(flag == true || i== memberTypeToMembers[memberType].length - 2) {
                memberTypeToMembers[memberType][i] = memberTypeToMembers[memberType][i+1];
            }
        }
        delete memberTypeToMembers[memberType][memberTypeToMembers[memberType].length-1];
    }

    function removeMember(address targetMember) internal {
        require(memberId[targetMember] != 0);
        for (uint j = memberId[targetMember]; j<members.length-1; j++){
            members[j] = members[j+1];
        }
        delete members[members.length-1];

        removeMemberFromMemberTypeArray(targetMember);

        memberId[targetMember] = 0;
        memberAddressToMemberType[targetMember] = bytes32(0);
        votingPoints[targetMember] = 0;
        members.length--;
    }

    function getMemberId(address _memberAddress) public view returns (uint) {
        return memberId[msg.sender];
    }


    function changeMemberType(
        address _memberAddress,
        bytes32 _newType)
    internal {
        require(memberId[_memberAddress] != 0);
        require(checkIfMemberTypeExists(_newType));
        uint id = memberId[_memberAddress];
        memberAddressToMemberType[_memberAddress] = _newType;
        Member memory m = members[id];
        m.memberType = _newType;
        members[id] = m;
    }


    function checkIfMemberTypeExists(bytes32 memberType) public view returns (bool) {
        for(uint i=0; i<memberTypes.length; i++) {
            if(memberTypes[i] == memberType) {
                return true;
            }
        }
        return false;
    }

    /// @notice Function to return all the members from Liberland
    function getAllMembers() public view returns (address[],bytes32[],bytes32[],bytes32[], bytes32[]) {
        uint length = members.length - 1;
        address[] memory allMemberAddresses = new address[](length);
        bytes32[] memory allMemberUsernames = new bytes32[](length);
        bytes32[] memory allMemberFullNames = new bytes32[](length);
        bytes32[] memory allMemberEmails = new bytes32[](length);
        bytes32[] memory allMemberTypes = new bytes32[](length);

        for(uint i=1; i<length + 1; i++) {
            Member memory m = members[i];
            allMemberAddresses[i-1] = m.memberAddress;
            allMemberUsernames[i-1] = m.username;
            allMemberFullNames[i-1] = m.fullName;
            allMemberEmails[i-1] = m.email;
            allMemberTypes[i-1] = m.memberType;
        }
        return (allMemberAddresses, allMemberUsernames, allMemberFullNames, allMemberEmails, allMemberTypes);
    }


    function getAllMembersForType(bytes32 memberType) public view returns (address[]) {
        return memberTypeToMembers[memberType];
    }

    function getLimitForType(bytes32 memberType) public view returns(uint) {
        return limitOfMembersPerType[memberType];
    }

    function getMembersVotingPoints(address _memberAddress) public view returns (uint) {
        return votingPoints[_memberAddress];
    }


    function startCampagin(
        string description,
        uint votingCampaignLengthInDays,
        address twoKeyWeightedVoteContract,
        uint flag //if 0 then voting else petitioning
    ) public {
        require(memberId[msg.sender] != 0);
        bytes32 _campaignType;
        if(flag == 0) {
            _campaignType = bytes32("VOTING");
        } else {
            _campaignType = bytes32("PETITIONING");
        }

        Campaign memory cmp = Campaign({
            votingReason: description,
            finished: false,
            votesYes: 0,
            votesNo: 0,
            votingResultForYes: 0,
            votingResultForNo: 0,
            votingCampaignLengthInDays: votingCampaignLengthInDays,
            campaignType: _campaignType,
            votingContract: twoKeyWeightedVoteContract
        });

        votingContractToCampaign[twoKeyWeightedVoteContract] = cmp;
        ITwoKeyWeightedVoteContract(twoKeyWeightedVoteContract).setValid();
        allCampaigns.push(cmp);
        numberOfVotingCamapignsAndPetitions++;
    }



    function getResultsForVoting(address weightedVoteContractAddress) public view returns (uint,uint,uint,uint,uint,uint) {
        return ITwoKeyWeightedVoteContract(weightedVoteContractAddress).getDynamicData();
    }


    function executeVoting(uint campaign_id, bytes signature) public returns (uint) {

        Campaign memory campaign = allCampaigns[campaign_id];

        require(campaign.finished == false);
//        require(block.timestamp > nvc.votingCampaignLengthInDays);
        ITwoKeyWeightedVoteContract(campaign.votingContract).transferSig(signature);
        address [] memory allParticipants = ITwoKeyWeightedVoteContract(campaign.votingContract).getAllVoters();

        for(uint i=0; i<allParticipants.length; i++) {
            bool vote;
            uint power;

            (vote,power) = ITwoKeyWeightedVoteContract(campaign.votingContract).getVoteAndChoicePerAddress(allParticipants[i]);

            if(vote == true) {
                campaign.votesYes++;
                campaign.votingResultForYes += int(power);
            }
            if(vote == false){
                campaign.votesNo++;
                campaign.votingResultForNo += int(power);
            }
        }
        campaign.finished = true;
        allCampaigns[campaign_id] = campaign;
    }

    function getNumberOfVotingCampaigns() public view returns (uint) {
        return numberOfVotingCamapignsAndPetitions;
    }

    function getCampaignByAddressOfVoteContract(address voteContract) public view returns (string, bool, uint, uint, int, int, uint, bytes32, address) {
        Campaign memory campaign = votingContractToCampaign[voteContract];
        return (
        campaign.votingReason,
        campaign.finished,
        campaign.votesYes,
        campaign.votesNo,
        campaign.votingResultForYes,
        campaign.votingResultForNo,
        campaign.votingCampaignLengthInDays,
        campaign.campaignType,
        campaign.votingContract);
    }


    function getCampaign(uint id) public view returns (string, bool, uint, uint, int, int, uint, bytes32, address) {
        Campaign memory campaign = allCampaigns[id];
        return (
            campaign.votingReason,
            campaign.finished,
            campaign.votesYes,
            campaign.votesNo,
            campaign.votingResultForYes,
            campaign.votingResultForNo,
            campaign.votingCampaignLengthInDays,
            campaign.campaignType,
            campaign.votingContract);
    }


    function getNameAndIpfsHashes() public view returns (string,string,string) {
        return (nationName, ipfsForConstitution, ipfsHashForDAOPublicInfo);
    }

    function getMemberid(address _member) public view returns (uint) {
        return memberId[_member];
    }

}
