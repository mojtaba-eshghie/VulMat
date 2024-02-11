// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/SafeMath.sol

pragma solidity ^0.5.0;


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

    /**
    * @dev Multiplies two numbers, throws on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
        // Gas optimization: this is cheaper than asserting 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        c = a * b;
        assert(c / a == b);
        return c;
    }

    /**
    * @dev Integer division of two numbers, truncating the quotient.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        // uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return a / b;
    }

    /**
    * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    /**
    * @dev Adds two numbers, throws on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
        c = a + b;
        assert(c >= a);
        return c;
    }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/Address.sol

pragma solidity ^0.5.0;


/**
 * Utility library of inline functions on addresses
 */
library Address {

    /**
     * Returns whether the target address is a contract
     * @dev This function will return false if invoked during the constructor of a contract,
     * as the code is not actually created until after the constructor finishes.
     * @param account address of the account to check
     * @return whether the target address is a contract
     */
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        // XXX Currently there is no better way to check if there is a contract in an address
        // than to check the size of the code at that address.
        // See https://ethereum.stackexchange.com/a/14016/36603
        // for more details about how this works.
        // TODO Check this again before the Serenity release, because all addresses will be
        // contracts then.
        // solium-disable-next-line security/no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/Common.sol

pragma solidity ^0.5.0;

/**
    Note: Simple contract to use as base for const vals
*/
contract CommonConstants {

    bytes4 constant internal ERC1155_ACCEPTED = 0xf23a6e61; // bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))
    bytes4 constant internal ERC1155_BATCH_ACCEPTED = 0xbc197c81; // bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/IERC1155TokenReceiver.sol

pragma solidity ^0.5.0;

/**
    Note: The ERC-165 identifier for this interface is 0x4e2312e0.
*/
interface ERC1155TokenReceiver {
    /**
        @notice Handle the receipt of a single ERC1155 token type.
        @dev An ERC1155-compliant smart contract MUST call this function on the token recipient contract, at the end of a `safeTransferFrom` after the balance has been updated.
        This function MUST return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))` (i.e. 0xf23a6e61) if it accepts the transfer.
        This function MUST revert if it rejects the transfer.
        Return of any other value than the prescribed keccak256 generated value MUST result in the transaction being reverted by the caller.
        @param _operator  The address which initiated the transfer (i.e. msg.sender)
        @param _from      The address which previously owned the token
        @param _id        The ID of the token being transferred
        @param _value     The amount of tokens being transferred
        @param _data      Additional data with no specified format
        @return           `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
    */
    function onERC1155Received(address _operator, address _from, uint256 _id, uint256 _value, bytes calldata _data) external returns(bytes4);

    /**
        @notice Handle the receipt of multiple ERC1155 token types.
        @dev An ERC1155-compliant smart contract MUST call this function on the token recipient contract, at the end of a `safeBatchTransferFrom` after the balances have been updated.
        This function MUST return `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))` (i.e. 0xbc197c81) if it accepts the transfer(s).
        This function MUST revert if it rejects the transfer(s).
        Return of any other value than the prescribed keccak256 generated value MUST result in the transaction being reverted by the caller.
        @param _operator  The address which initiated the batch transfer (i.e. msg.sender)
        @param _from      The address which previously owned the token
        @param _ids       An array containing ids of each token being transferred (order and length must match _values array)
        @param _values    An array containing amounts of each token being transferred (order and length must match _ids array)
        @param _data      Additional data with no specified format
        @return           `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
    */
    function onERC1155BatchReceived(address _operator, address _from, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external returns(bytes4);
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/ERC165.sol

pragma solidity ^0.5.0;


/**
 * @title ERC165
 * @dev https://github.com/ethereum/EIPs/blob/master/EIPS/eip-165.md
 */
interface ERC165 {

    /**
     * @notice Query if a contract implements an interface
     * @param _interfaceId The interface identifier, as specified in ERC-165
     * @dev Interface identification is specified in ERC-165. This function
     * uses less than 30,000 gas.
     */
    function supportsInterface(bytes4 _interfaceId)
    external
    view
    returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/IERC1155.sol

pragma solidity ^0.5.0;

/**
    @title ERC-1155 Multi Token Standard
    @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1155.md
    Note: The ERC-165 identifier for this interface is 0xd9b67a26.
 */
interface IERC1155 /* is ERC165 */ {
    /**
        @dev Either `TransferSingle` or `TransferBatch` MUST emit when tokens are transferred, including zero value transfers as well as minting or burning (see "Safe Transfer Rules" section of the standard).
        The `_operator` argument MUST be msg.sender.
        The `_from` argument MUST be the address of the holder whose balance is decreased.
        The `_to` argument MUST be the address of the recipient whose balance is increased.
        The `_id` argument MUST be the token type being transferred.
        The `_value` argument MUST be the number of tokens the holder balance is decreased by and match what the recipient balance is increased by.
        When minting/creating tokens, the `_from` argument MUST be set to `0x0` (i.e. zero address).
        When burning/destroying tokens, the `_to` argument MUST be set to `0x0` (i.e. zero address).
    */
    event TransferSingle(address indexed _operator, address indexed _from, address indexed _to, uint256 _id, uint256 _value);

    /**
        @dev Either `TransferSingle` or `TransferBatch` MUST emit when tokens are transferred, including zero value transfers as well as minting or burning (see "Safe Transfer Rules" section of the standard).
        The `_operator` argument MUST be msg.sender.
        The `_from` argument MUST be the address of the holder whose balance is decreased.
        The `_to` argument MUST be the address of the recipient whose balance is increased.
        The `_ids` argument MUST be the list of tokens being transferred.
        The `_values` argument MUST be the list of number of tokens (matching the list and order of tokens specified in _ids) the holder balance is decreased by and match what the recipient balance is increased by.
        When minting/creating tokens, the `_from` argument MUST be set to `0x0` (i.e. zero address).
        When burning/destroying tokens, the `_to` argument MUST be set to `0x0` (i.e. zero address).
    */
    event TransferBatch(address indexed _operator, address indexed _from, address indexed _to, uint256[] _ids, uint256[] _values);

    /**
        @dev MUST emit when approval for a second party/operator address to manage all tokens for an owner address is enabled or disabled (absense of an event assumes disabled).
    */
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    /**
        @dev MUST emit when the URI is updated for a token ID.
        URIs are defined in RFC 3986.
        The URI MUST point a JSON file that conforms to the "ERC-1155 Metadata URI JSON Schema".
    */
    event URI(string _value, uint256 indexed _id);

    /**
        @notice Transfers `_value` amount of an `_id` from the `_from` address to the `_to` address specified (with safety call).
        @dev Caller must be approved to manage the tokens being transferred out of the `_from` account (see "Approval" section of the standard).
        MUST revert if `_to` is the zero address.
        MUST revert if balance of holder for token `_id` is lower than the `_value` sent.
        MUST revert on any other error.
        MUST emit the `TransferSingle` event to reflect the balance change (see "Safe Transfer Rules" section of the standard).
        After the above conditions are met, this function MUST check if `_to` is a smart contract (e.g. code size > 0). If so, it MUST call `onERC1155Received` on `_to` and act appropriately (see "Safe Transfer Rules" section of the standard).
        @param _from    Source address
        @param _to      Target address
        @param _id      ID of the token type
        @param _value   Transfer amount
        @param _data    Additional data with no specified format, MUST be sent unaltered in call to `onERC1155Received` on `_to`
    */
    function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) external;

    /**
        @notice Transfers `_values` amount(s) of `_ids` from the `_from` address to the `_to` address specified (with safety call).
        @dev Caller must be approved to manage the tokens being transferred out of the `_from` account (see "Approval" section of the standard).
        MUST revert if `_to` is the zero address.
        MUST revert if length of `_ids` is not the same as length of `_values`.
        MUST revert if any of the balance(s) of the holder(s) for token(s) in `_ids` is lower than the respective amount(s) in `_values` sent to the recipient.
        MUST revert on any other error.
        MUST emit `TransferSingle` or `TransferBatch` event(s) such that all the balance changes are reflected (see "Safe Transfer Rules" section of the standard).
        Balance changes and events MUST follow the ordering of the arrays (_ids[0]/_values[0] before _ids[1]/_values[1], etc).
        After the above conditions for the transfer(s) in the batch are met, this function MUST check if `_to` is a smart contract (e.g. code size > 0). If so, it MUST call the relevant `ERC1155TokenReceiver` hook(s) on `_to` and act appropriately (see "Safe Transfer Rules" section of the standard).
        @param _from    Source address
        @param _to      Target address
        @param _ids     IDs of each token type (order and length must match _values array)
        @param _values  Transfer amounts per token type (order and length must match _ids array)
        @param _data    Additional data with no specified format, MUST be sent unaltered in call to the `ERC1155TokenReceiver` hook(s) on `_to`
    */
    function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external;

    /**
        @notice Get the balance of an account's Tokens.
        @param _owner  The address of the token holder
        @param _id     ID of the Token
        @return        The _owner's balance of the Token type requested
     */
    function balanceOf(address _owner, uint256 _id) external view returns (uint256);

    /**
        @notice Get the balance of multiple account/token pairs
        @param _owners The addresses of the token holders
        @param _ids    ID of the Tokens
        @return        The _owner's balance of the Token types requested (i.e. balance for each (owner, id) pair)
     */
    function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory);

    /**
        @notice Enable or disable approval for a third party ("operator") to manage all of the caller's tokens.
        @dev MUST emit the ApprovalForAll event on success.
        @param _operator  Address to add to the set of authorized operators
        @param _approved  True if the operator is approved, false to revoke approval
    */
    function setApprovalForAll(address _operator, bool _approved) external;

    /**
        @notice Queries the approval status of an operator for a given owner.
        @param _owner     The owner of the Tokens
        @param _operator  Address of authorized operator
        @return           True if the operator is approved, false if not
    */
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/ERC1155.sol

pragma solidity ^0.5.0;





// A sample implementation of core ERC1155 function.
contract ERC1155 is IERC1155, ERC165, CommonConstants
{
    using SafeMath for uint256;
    using Address for address;

    // id => (owner => balance)
    mapping (uint256 => mapping(address => uint256)) internal balances;

    // owner => (operator => approved)
    mapping (address => mapping(address => bool)) internal operatorApproval;

/////////////////////////////////////////// ERC165 //////////////////////////////////////////////

    /*
        bytes4(keccak256('supportsInterface(bytes4)'));
    */
    bytes4 constant private INTERFACE_SIGNATURE_ERC165 = 0x01ffc9a7;

    /*
        bytes4(keccak256("safeTransferFrom(address,address,uint256,uint256,bytes)")) ^
        bytes4(keccak256("safeBatchTransferFrom(address,address,uint256[],uint256[],bytes)")) ^
        bytes4(keccak256("balanceOf(address,uint256)")) ^
        bytes4(keccak256("balanceOfBatch(address[],uint256[])")) ^
        bytes4(keccak256("setApprovalForAll(address,bool)")) ^
        bytes4(keccak256("isApprovedForAll(address,address)"));
    */
    bytes4 constant private INTERFACE_SIGNATURE_ERC1155 = 0xd9b67a26;

    function supportsInterface(bytes4 _interfaceId)
    public
    view
    returns (bool) {
         if (_interfaceId == INTERFACE_SIGNATURE_ERC165 ||
             _interfaceId == INTERFACE_SIGNATURE_ERC1155) {
            return true;
         }

         return false;
    }

/////////////////////////////////////////// ERC1155 //////////////////////////////////////////////

    /**
        @notice Transfers `_value` amount of an `_id` from the `_from` address to the `_to` address specified (with safety call).
        @dev Caller must be approved to manage the tokens being transferred out of the `_from` account (see "Approval" section of the standard).
        MUST revert if `_to` is the zero address.
        MUST revert if balance of holder for token `_id` is lower than the `_value` sent.
        MUST revert on any other error.
        MUST emit the `TransferSingle` event to reflect the balance change (see "Safe Transfer Rules" section of the standard).
        After the above conditions are met, this function MUST check if `_to` is a smart contract (e.g. code size > 0). If so, it MUST call `onERC1155Received` on `_to` and act appropriately (see "Safe Transfer Rules" section of the standard).
        @param _from    Source address
        @param _to      Target address
        @param _id      ID of the token type
        @param _value   Transfer amount
        @param _data    Additional data with no specified format, MUST be sent unaltered in call to `onERC1155Received` on `_to`
    */
    function safeTransferFrom(address _from, address _to, uint256 _id, uint256 _value, bytes calldata _data) external {

        require(_to != address(0x0), "_to must be non-zero.");
        require(_from == msg.sender || operatorApproval[_from][msg.sender] == true, "Need operator approval for 3rd party transfers.");

        // SafeMath will throw with insuficient funds _from
        // or if _id is not valid (balance will be 0)
        balances[_id][_from] = balances[_id][_from].sub(_value);
        balances[_id][_to]   = _value.add(balances[_id][_to]);

        // MUST emit event
        emit TransferSingle(msg.sender, _from, _to, _id, _value);

        // Now that the balance is updated and the event was emitted,
        // call onERC1155Received if the destination is a contract.
        if (_to.isContract()) {
            _doSafeTransferAcceptanceCheck(msg.sender, _from, _to, _id, _value, _data);
        }
    }

    /**
        @notice Transfers `_values` amount(s) of `_ids` from the `_from` address to the `_to` address specified (with safety call).
        @dev Caller must be approved to manage the tokens being transferred out of the `_from` account (see "Approval" section of the standard).
        MUST revert if `_to` is the zero address.
        MUST revert if length of `_ids` is not the same as length of `_values`.
        MUST revert if any of the balance(s) of the holder(s) for token(s) in `_ids` is lower than the respective amount(s) in `_values` sent to the recipient.
        MUST revert on any other error.
        MUST emit `TransferSingle` or `TransferBatch` event(s) such that all the balance changes are reflected (see "Safe Transfer Rules" section of the standard).
        Balance changes and events MUST follow the ordering of the arrays (_ids[0]/_values[0] before _ids[1]/_values[1], etc).
        After the above conditions for the transfer(s) in the batch are met, this function MUST check if `_to` is a smart contract (e.g. code size > 0). If so, it MUST call the relevant `ERC1155TokenReceiver` hook(s) on `_to` and act appropriately (see "Safe Transfer Rules" section of the standard).
        @param _from    Source address
        @param _to      Target address
        @param _ids     IDs of each token type (order and length must match _values array)
        @param _values  Transfer amounts per token type (order and length must match _ids array)
        @param _data    Additional data with no specified format, MUST be sent unaltered in call to the `ERC1155TokenReceiver` hook(s) on `_to`
    */
    function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, uint256[] calldata _values, bytes calldata _data) external {

        // MUST Throw on errors
        require(_to != address(0x0), "destination address must be non-zero.");
        require(_ids.length == _values.length, "_ids and _values array length must match.");
        require(_from == msg.sender || operatorApproval[_from][msg.sender] == true, "Need operator approval for 3rd party transfers.");

        for (uint256 i = 0; i < _ids.length; ++i) {
            uint256 id = _ids[i];
            uint256 value = _values[i];

            // SafeMath will throw with insuficient funds _from
            // or if _id is not valid (balance will be 0)
            balances[id][_from] = balances[id][_from].sub(value);
            balances[id][_to]   = value.add(balances[id][_to]);
        }

        // Note: instead of the below batch versions of event and acceptance check you MAY have emitted a TransferSingle
        // event and a subsequent call to _doSafeTransferAcceptanceCheck in above loop for each balance change instead.
        // Or emitted a TransferSingle event for each in the loop and then the single _doSafeBatchTransferAcceptanceCheck below.
        // However it is implemented the balance changes and events MUST match when a check (i.e. calling an external contract) is done.

        // MUST emit event
        emit TransferBatch(msg.sender, _from, _to, _ids, _values);

        // Now that the balances are updated and the events are emitted,
        // call onERC1155BatchReceived if the destination is a contract.
        if (_to.isContract()) {
            _doSafeBatchTransferAcceptanceCheck(msg.sender, _from, _to, _ids, _values, _data);
        }
    }

    /**
        @notice Get the balance of an account's Tokens.
        @param _owner  The address of the token holder
        @param _id     ID of the Token
        @return        The _owner's balance of the Token type requested
     */
    function balanceOf(address _owner, uint256 _id) external view returns (uint256) {
        // The balance of any account can be calculated from the Transfer events history.
        // However, since we need to keep the balances to validate transfer request,
        // there is no extra cost to also privide a querry function.
        return balances[_id][_owner];
    }


    /**
        @notice Get the balance of multiple account/token pairs
        @param _owners The addresses of the token holders
        @param _ids    ID of the Tokens
        @return        The _owner's balance of the Token types requested (i.e. balance for each (owner, id) pair)
     */
    function balanceOfBatch(address[] calldata _owners, uint256[] calldata _ids) external view returns (uint256[] memory) {

        require(_owners.length == _ids.length);

        uint256[] memory balances_ = new uint256[](_owners.length);

        for (uint256 i = 0; i < _owners.length; ++i) {
            balances_[i] = balances[_ids[i]][_owners[i]];
        }

        return balances_;
    }

    /**
        @notice Enable or disable approval for a third party ("operator") to manage all of the caller's tokens.
        @dev MUST emit the ApprovalForAll event on success.
        @param _operator  Address to add to the set of authorized operators
        @param _approved  True if the operator is approved, false to revoke approval
    */
    function setApprovalForAll(address _operator, bool _approved) external {
        operatorApproval[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    /**
        @notice Queries the approval status of an operator for a given owner.
        @param _owner     The owner of the Tokens
        @param _operator  Address of authorized operator
        @return           True if the operator is approved, false if not
    */
    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return operatorApproval[_owner][_operator];
    }

/////////////////////////////////////////// Internal //////////////////////////////////////////////

    function _doSafeTransferAcceptanceCheck(address _operator, address _from, address _to, uint256 _id, uint256 _value, bytes memory _data) internal {

        // If this was a hybrid standards solution you would have to check ERC165(_to).supportsInterface(0x4e2312e0) here but as this is a pure implementation of an ERC-1155 token set as recommended by
        // the standard, it is not necessary. The below should revert in all failure cases i.e. _to isn't a receiver, or it is and either returns an unknown value or it reverts in the call to indicate non-acceptance.


        // Note: if the below reverts in the onERC1155Received function of the _to address you will have an undefined revert reason returned rather than the one in the require test.
        // If you want predictable revert reasons consider using low level _to.call() style instead so the revert does not bubble up and you can revert yourself on the ERC1155_ACCEPTED test.
        require(ERC1155TokenReceiver(_to).onERC1155Received(_operator, _from, _id, _value, _data) == ERC1155_ACCEPTED, "contract returned an unknown value from onERC1155Received");
    }

    function _doSafeBatchTransferAcceptanceCheck(address _operator, address _from, address _to, uint256[] memory _ids, uint256[] memory _values, bytes memory _data) internal {

        // If this was a hybrid standards solution you would have to check ERC165(_to).supportsInterface(0x4e2312e0) here but as this is a pure implementation of an ERC-1155 token set as recommended by
        // the standard, it is not necessary. The below should revert in all failure cases i.e. _to isn't a receiver, or it is and either returns an unknown value or it reverts in the call to indicate non-acceptance.

        // Note: if the below reverts in the onERC1155BatchReceived function of the _to address you will have an undefined revert reason returned rather than the one in the require test.
        // If you want predictable revert reasons consider using low level _to.call() style instead so the revert does not bubble up and you can revert yourself on the ERC1155_BATCH_ACCEPTED test.
        require(ERC1155TokenReceiver(_to).onERC1155BatchReceived(_operator, _from, _ids, _values, _data) == ERC1155_BATCH_ACCEPTED, "contract returned an unknown value from onERC1155BatchReceived");
    }
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/ICurio.sol

pragma solidity ^0.5.0;

// Curio is not quite ERC-20 compliant
interface ICurio {
  function balanceOf(address account) external view returns (uint256);
  function allowance(address owner, address spender) external view returns (uint256);
  function transferFrom(address _from, address _to, uint256 _value) external;
  function transfer(address _to, uint256 _value) external;
  function ipfs_hash() external view returns (string memory);
}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/AbstractWrapper.sol

pragma solidity ^0.5.0;




contract AbstractWrapper is ERC1155 {
    using SafeMath for uint256;
    using Address for address;

    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // nft id => curio contract address
    mapping (uint256 => address) public contracts;
    // nft id => nft metadata IPFS URI
    mapping (uint256 => string) public metadatas;

    // OpenSea contract with an operator => proxy lister contract address
    address public proxyRegistryAddress;

    function initialize() internal;

    /**
        @notice Initialize an nft id's data.
    */
    function create(uint256 _id, address _contract, string memory _uri) internal {

        require(contracts[_id] == address(0), "id already exists");
        contracts[_id] = _contract;

        // mint 0 just to let explorers know it exists
        emit TransferSingle(msg.sender, address(0), msg.sender, _id, 0);

        metadatas[_id] = _uri;
        emit URI(_uri, _id);
    }

    constructor(address _proxyRegistryAddress) public {
        proxyRegistryAddress = _proxyRegistryAddress;
        _owner = msg.sender;
        initialize();
    }

    /**
       @return the address of the owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Not owner");
        _;
    }

    /**
     * @return true if `msg.sender` is the owner of the contract.
     */
    function isOwner() public view returns (bool) {
        return msg.sender == _owner;
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0));
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    /**
        @dev override ERC1155 uri function to return IPFS ref.
        @param _id NFT ID
        @return IPFS URI pointing to NFT ID's metadata.
    */
    function uri(uint256 _id) public view returns (string memory) {
        return metadatas[_id];
    }

    /**
        @dev helper function to see if NFT ID exists, makes OpenSea happy.
        @param _id NFT ID
        @return if NFT ID exists.
    */
    function exists(uint256 _id) external view returns(bool) {
        return contracts[_id] != address(0);
    }

    /**
        @dev for an NFT ID, queries and transfers tokens from the appropriate
        curio contract to itself, and mints and transfers corresponding new
        ERC-1155 tokens to caller.
     */
    function wrap(uint256 _id, uint256 _quantity) external {
        address tokenContract = contracts[_id];
        require(tokenContract != address(0), "invalid id");
        ICurio curio = ICurio(tokenContract);

        // these are here for convenience because curio contract doesn't throw meaningful exceptions
        require(curio.balanceOf(msg.sender) >= _quantity, "insufficient curio balance");
        require(curio.allowance(msg.sender, address(this)) >= _quantity, "insufficient curio allowance");
        
        curio.transferFrom(msg.sender, address(this), _quantity);

        balances[_id][msg.sender] = balances[_id][msg.sender].add(_quantity);

        // mint
        emit TransferSingle(msg.sender, address(0), msg.sender, _id, _quantity);

        address _to = msg.sender;
        if (_to.isContract()) {
           _doSafeTransferAcceptanceCheck(msg.sender, msg.sender, msg.sender, _id, _quantity, '');
        }
    }

    /**
        @dev batch version of wrap.
     */
    function wrapBatch(uint256[] calldata _ids, uint256[] calldata _quantities) external {
        require(_ids.length == _quantities.length, "ids and quantities must match");

        address _to = msg.sender;

        for (uint256 i=0; i < _ids.length; ++i) {
            uint256 _id = _ids[i];
            uint256 _quantity = _quantities[i];

            address tokenContract = contracts[_id];
            require(tokenContract != address(0), "invalid id");
            ICurio curio = ICurio(tokenContract);

            require(curio.balanceOf(msg.sender) >= _quantity, "insufficient curio balance");
            require(curio.allowance(msg.sender, address(this)) >= _quantity, "insufficient curio allowance");

            curio.transferFrom(msg.sender, address(this), _quantity);

            balances[_id][msg.sender] = balances[_id][msg.sender].add(_quantity);

            // mint
            // we are not doing a batch event because testnet opensea didn't recognize it
            emit TransferSingle(msg.sender, address(0), msg.sender, _id, _quantity);

            if (_to.isContract()) {
                _doSafeTransferAcceptanceCheck(msg.sender, msg.sender, msg.sender, _id, _quantity, '');
            }
        }
    }

    /**
        @dev for an NFT ID, burns ERC-1155 quantity and transfers curio ERC-20
        tokens to caller.
     */
    function unwrap(uint256 _id, uint256 _quantity) external {
        address tokenContract = contracts[_id];
        require(tokenContract != address(0), "invalid id");
        ICurio curio = ICurio(tokenContract);

        require(balances[_id][msg.sender] >= _quantity, "insufficient balance");
        balances[_id][msg.sender] = balances[_id][msg.sender].sub(_quantity);

        curio.transfer(msg.sender, _quantity);

        // burn
        emit TransferSingle(msg.sender, address(this), address(0), _id, _quantity);
    }

    /**
        @dev batch version of unwrap.
     */
    function unwrapBatch(uint256[] calldata _ids, uint256[] calldata _quantities) external {
        require(_ids.length == _quantities.length, "ids and quantities must match");

        for (uint256 i=0; i < _ids.length; ++i) {
            uint256 _id = _ids[i];
            uint256 _quantity = _quantities[i];

            address tokenContract = contracts[_id];
            require(tokenContract != address(0), "invalid id");
            ICurio curio = ICurio(tokenContract);

            require(balances[_id][msg.sender] >= _quantity, "insufficient balance");
            balances[_id][msg.sender] = balances[_id][msg.sender].sub(_quantity);

            curio.transfer(msg.sender, _quantity);

            // burn
            emit TransferSingle(msg.sender, address(this), address(0), _id, _quantity);
        }

    }

}

// File: ../sc_datasets/DAppSCAN/Chainsulting-Nexxo/Smart-Contract-Security-Audits-master/Curio Cards/contracts-wrapper/CurioERC1155Wrapper.sol

pragma solidity ^0.5.0;

contract CurioERC1155Wrapper is AbstractWrapper {

    function initialize() internal {
        create(1, 0x6Aa2044C7A0f9e2758EdAE97247B03a0D7e73d6c, "ipfs://QmWHUnrdfA4w89TeepZqrvygbaF9wV48k97Wf27skL5cry");
        create(2, 0xE9A6A26598B05dB855483fF5eCc5f1d0C81140c8, "ipfs://QmVJn6B289Xt3cq9evzubdyk4f1usPAu277SmUusmdYYWU");
        create(3, 0x3f8131B6E62472CEea9cb8Aa67d87425248a3702, "ipfs://QmWBb6T4nviPWdAyqGJTki7VA6fpTmcYP37U9jpYAfhzPP");
        create(4, 0x4F1694be039e447B729ab11653304232Ae143C69, "ipfs://Qmbcw8ix8xdK1reFpDEjKtk9EWuRwrbMKqvEvWkttNzXkH");
        create(5, 0x5a3D4A8575a688b53E8b270b5C1f26fd63065219, "ipfs://QmXmj9YdsvBVddzC352Xsh7bmyJtfZvbVJeetK7PXW21p8");
        create(6, 0x1Ca6AC0Ce771094F0F8a383D46BF3acC9a5BF27f, "ipfs://Qmdf16YMPM7zG5QkSYB4HjbxQPaStYazsL6d1npdJG8J7h");
        create(7, 0x2647bd8777e0C66819D74aB3479372eA690912c3, "ipfs://QmUGmWwrNR7JKBCSu3CkGnTYSFat7y2AiUzACcbAoZcj2d");
        create(8, 0x2FCE2713a561bB019BC5A110BE0A19d10581ee9e, "ipfs://QmXQfBgJRsUQbf8UkViATdpsySXzREsifegWzLvw5QsQPj");
        create(9, 0xbf4Cc966F1e726087c5C55aac374E687000d4d45, "ipfs://Qmctv89ppbYTuwCWVFA9waVCeE8g6YM3Ah54bZW1WGmEHh");
        create(10, 0x72b34d637C0d14acE58359Ef1bF472E4b4c57125, "ipfs://QmaSBVrCcBsYHjVuvTsj6ev4Pua7NYX7sDNzdAYwCdAAne");
        create(11, 0xb36c87F1f1539c5FC6f6e7b1C632e1840C9B66b4, "ipfs://QmZjSs71uBYYdLx5Ju443KiSYjxQcJQLL5ZnhuzWX6nC19");
        create(12, 0xD15af10A258432e7227367499E785C3532b50271, "ipfs://QmQqMKDMKiRhgbFBrmAJPknzYHEKuH7VrqPZ7NS5vFoy78");
        create(13, 0x2d922712f5e99428c65b44f09Ea389373d185bB3, "ipfs://QmeShnRPe6uiRcBy81nQXDZ9TWUpFNQfiAThf9ruAQGcRa");
        create(14, 0x0565ac44e5119a3224b897De761a46A92aA28ae8, "ipfs://Qmdi8vQuQQWksiM5HCCVXfzSzcaemzQwYkUe4Tb94DP6vK");
        create(15, 0xdb7F262237Ad8acca8922aA2c693a34D0d13e8fe, "ipfs://QmS3UF256kWHbX8Wi7CYExyCxzLNX1nsaMwpaGBN73rr31");
        create(16, 0x1b63532CcB1FeE0595c7fe2Cb35cFD70ddF862Cd, "ipfs://Qmbj1YCmQidTzxgjLmu1b99PPdXZLSgk72YZQSt9LEEe1R");
        create(17, 0xF59536290906F204C3c7918D40C1Cc5f99643d0B, "ipfs://QmbDsZABRUPMcuoFWePRH7YiGyR64udWHc4u1mQPJYmB2c");
        create(18, 0xA507D9d28bbca54cBCfFad4BB770C2EA0519F4F0, "ipfs://QmXafwRpoJPiiQ9TZihhbSsFmgKqKMqrHSRLkp1wyQ3jUU");
        create(19, 0xf26BC97Aa8AFE176e275Cf3b08c363f09De371fA, "ipfs://QmTWJR1XJ2svexE2NT3A6cCtks8rgh6TKYaLYXwfHapNDN");
        create(20, 0xD0ec99E99cE22f2487283A087614AEe37F6B1283, "ipfs://Qmd3HzUX52MmZcj1Se3ocgYWEJWSvzSceEqQFV1YL7LRWL");
        create(21, 0xB7A5a84Ff90e8Ef91250fB56c50a7bB92a6306EE, "ipfs://QmX6stsihT3SNUakiFQLWU1cjvH7rC3pqtCnToxNn2T8JS");
        create(22, 0x148fF761D16632da89F3D30eF3dFE34bc50CA765, "ipfs://Qmc1sj8LRdfbPinoqKMmAe6UvJUG33VMmSU3XzNK2GnjJB");
        create(23, 0xCDE7185B5C3Ed9eA68605a960F6653AA1a5b5C6C, "ipfs://Qmdwh3S4imtE5RxZ4ddAzy3DMqNrD11JL6SATTyREuvrtN");
        create(24, 0xE67dad99c44547B54367E3e60fc251fC45a145C6, "ipfs://QmbfTxH6XvbgGcyWWaygmPko6NQ6tKuT6dJj5WjnQGp5g8");
        create(25, 0xC7f60C2b1DBDfd511685501EDEb05C4194D67018, "ipfs://QmXHyK19F4sMAUi6XYz1BJJYzxsdp8koVnL4BwsFA93Q47");
        create(26, 0x1cB5BF4Be53eb141B56f7E4Bb36345a353B5488c, "ipfs://QmYK88qy84rcL46CZGPqpKRm4fE2PQYJ931pV69ZNi4J1D");
        create(27, 0xFb9F3fa2502d01d43167A0A6E80bE03171DF407E, "ipfs://QmcUTEkPpmRPHCHiXskd9daQcEZwGzkHgybZmCWmFYha1T");
        create(28, 0x59D190e8A2583C67E62eEc8dA5EA7f050d8BF27e, "ipfs://QmTmi8j5BBE5FWhEDAg1bTqpmkkEcaPgTUeYFJ4z3PxXqN");
        create(29, 0xD3540bCD9c2819771F9D765Edc189cBD915FEAbd, "ipfs://QmVTGJtgnUgnMPttJV2VkfonCUYLRnJqX66gJLiig5QVgC");
        create(30, 0x7F5B230Dc580d1e67DF6eD30dEe82684dD113D1F, "ipfs://QmQBu8jYC3vEGzx59BUW4knBdNRyFd8aTVLLFCEprdjZ5e");
    }

    constructor(address _proxyRegistryAddress) AbstractWrapper(_proxyRegistryAddress) public {
    }

}
