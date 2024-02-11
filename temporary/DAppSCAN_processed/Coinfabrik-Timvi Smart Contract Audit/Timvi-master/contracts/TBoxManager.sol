// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IERC165.sol

pragma solidity 0.4.25;

/**
 * @title IERC165
 * @dev https://github.com/ethereum/EIPs/blob/master/EIPS/eip-165.md
 */
interface IERC165 {
    /**
     * @notice Query if a contract implements an interface
     * @param interfaceId The interface identifier, as specified in ERC-165
     * @dev Interface identification is specified in ERC-165. This function
     * uses less than 30,000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IERC721.sol

pragma solidity 0.4.25;

/**
 * @title ERC721 Non-Fungible Token Standard basic interface
 * @dev see https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
contract IERC721 is IERC165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) public view returns (uint256 balance);
    function ownerOf(uint256 tokenId) public view returns (address owner);

    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool);

    function transferFrom(address from, address to, uint256 tokenId) public;
    function safeTransferFrom(address from, address to, uint256 tokenId) public;

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public;
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IERC721Receiver.sol

pragma solidity 0.4.25;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
contract IERC721Receiver {
    /**
     * @notice Handle the receipt of an NFT
     * @dev The ERC721 smart contract calls this function on the recipient
     * after a `safeTransfer`. This function MUST return the function selector,
     * otherwise the caller will revert the transaction. The selector to be
     * returned can be obtained as `this.onERC721Received.selector`. This
     * function MAY throw to revert and reject the transfer.
     * Note: the ERC721 contract address is always the message sender.
     * @param operator The address which called `safeTransferFrom` function
     * @param from The address which previously owned the token
     * @param tokenId The NFT identifier which is being transferred
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data) public returns (bytes4);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/SafeMath.sol

pragma solidity 0.4.25;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that revert on error
 */
library SafeMath {
    /**
    * @dev Multiplies two numbers, reverts on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, 'mul');

        return c;
    }

    /**
    * @dev Integer division of two numbers truncating the quotient, reverts on division by zero.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, 'div');
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
    * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, 'sub');
        uint256 c = a - b;

        return c;
    }

    /**
    * @dev Adds two numbers, reverts on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, 'add');

        return c;
    }

    /**
    * @dev Divides two numbers and returns the remainder (unsigned integer modulo),
    * reverts when dividing by zero.
    */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b != 0);
        return a % b;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/Address.sol

pragma solidity 0.4.25;

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

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/ERC165.sol

pragma solidity 0.4.25;

/**
 * @title ERC165
 * @author Matt Condon (@shrugs)
 * @dev Implements ERC165 using a lookup table.
 */
contract ERC165 is IERC165 {
    bytes4 private constant _InterfaceId_ERC165 = 0x01ffc9a7;
    /**
     * 0x01ffc9a7 ===
     *     bytes4(keccak256('supportsInterface(bytes4)'))
     */

    /**
     * @dev a mapping of interface id to whether or not it's supported
     */
    mapping(bytes4 => bool) private _supportedInterfaces;

    /**
     * @dev A contract implementing SupportsInterfaceWithLookup
     * implement ERC165 itself
     */
    constructor () internal {
        _registerInterface(_InterfaceId_ERC165);
    }

    /**
     * @dev implement supportsInterface(bytes4) using a lookup table
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool) {
        return _supportedInterfaces[interfaceId];
    }

    /**
     * @dev internal method for registering an interface
     */
    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff);
        _supportedInterfaces[interfaceId] = true;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/ERC721.sol

pragma solidity 0.4.25;





/**
 * @title ERC721 Non-Fungible Token Standard basic implementation
 * @dev see https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
contract ERC721 is ERC165, IERC721 {
    using SafeMath for uint256;
    using Address for address;

    // Equals to `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`
    // which can be also obtained as `IERC721Receiver(0).onERC721Received.selector`
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    // Mapping from token ID to owner
    mapping (uint256 => address) internal _tokenOwner;

    // Mapping from token ID to approved address
    mapping (uint256 => address) private _tokenApprovals;

    // Mapping from owner to number of owned token
    mapping (address => uint256) private _ownedTokensCount;

    // Mapping from owner to operator approvals
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    bytes4 private constant _InterfaceId_ERC721 = 0x80ac58cd;
    /*
     * 0x80ac58cd ===
     *     bytes4(keccak256('balanceOf(address)')) ^
     *     bytes4(keccak256('ownerOf(uint256)')) ^
     *     bytes4(keccak256('approve(address,uint256)')) ^
     *     bytes4(keccak256('getApproved(uint256)')) ^
     *     bytes4(keccak256('setApprovalForAll(address,bool)')) ^
     *     bytes4(keccak256('isApprovedForAll(address,address)')) ^
     *     bytes4(keccak256('transferFrom(address,address,uint256)')) ^
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256)')) ^
     *     bytes4(keccak256('safeTransferFrom(address,address,uint256,bytes)'))
     */

    constructor () public {
        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(_InterfaceId_ERC721);
    }

    /**
     * @dev Gets the balance of the specified address
     * @param owner address to query the balance of
     * @return uint256 representing the amount owned by the passed address
     */
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0));
        return _ownedTokensCount[owner];
    }

    /**
     * @dev Gets the owner of the specified token ID
     * @param tokenId uint256 ID of the token to query the owner of
     * @return owner address currently marked as the owner of the given token ID
     */
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0));
        return owner;
    }

    /**
     * @dev Approves another address to transfer the given token ID
     * The zero address indicates there is no approved address.
     * There can only be one approved address per token at a given time.
     * Can only be called by the token owner or an approved operator.
     * @param to address to be approved for the given token ID
     * @param tokenId uint256 ID of the token to be approved
     */
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender));

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    /**
     * @dev Gets the approved address for a token ID, or zero if no address set
     * Reverts if the token ID does not exist.
     * @param tokenId uint256 ID of the token to query the approval of
     * @return address currently approved for the given token ID
     */
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId));
        return _tokenApprovals[tokenId];
    }

    /**
     * @dev Sets or unsets the approval of a given operator
     * An operator is allowed to transfer all tokens of the sender on their behalf
     * @param to operator address to set the approval
     * @param approved representing the status of the approval to be set
     */
    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender);
        _operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }

    /**
     * @dev Tells whether an operator is approved by a given owner
     * @param owner owner address which you want to query the approval of
     * @param operator operator address which you want to query the approval of
     * @return bool whether the given operator is approved by the given owner
     */
    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev Transfers the ownership of a given token ID to another address
     * Usage of this method is discouraged, use `safeTransferFrom` whenever possible
     * Requires the msg sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
    */
    function transferFrom(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId));
        require(to != address(0));

        _clearApproval(from, tokenId);
        _removeTokenFrom(from, tokenId);
        _addTokenTo(to, tokenId);

        emit Transfer(from, to, tokenId);
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     *
     * Requires the msg sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
    */
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        // solium-disable-next-line arg-overflow
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev Safely transfers the ownership of a given token ID to another address
     * If the target address is a contract, it must implement `onERC721Received`,
     * which is called upon a safe transfer, and return the magic value
     * `bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"))`; otherwise,
     * the transfer is reverted.
     * Requires the msg sender to be the owner, approved, or operator
     * @param from current owner of the token
     * @param to address to receive the ownership of the given token ID
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes data to send along with a safe transfer check
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        transferFrom(from, to, tokenId);
        // solium-disable-next-line arg-overflow
        require(_checkOnERC721Received(from, to, tokenId, _data));
    }

    /**
     * @dev Returns whether the specified token exists
     * @param tokenId uint256 ID of the token to query the existence of
     * @return whether the token exists
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    /**
     * @dev Returns whether the given spender can transfer a given token ID
     * @param spender address of the spender to query
     * @param tokenId uint256 ID of the token to be transferred
     * @return bool whether the msg.sender is approved for the given token ID,
     *    is an operator of the owner, or is the owner of the token
     */
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        address owner = ownerOf(tokenId);
        // Disable solium check because of
        // https://github.com/duaraghav8/Solium/issues/175
        // solium-disable-next-line operator-whitespace
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    /**
     * @dev Internal function to mint a new token
     * Reverts if the given token ID already exists
     * @param to The address that will own the minted token
     * @param tokenId uint256 ID of the token to be minted by the msg.sender
     */
    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0));
        _addTokenTo(to, tokenId);
        emit Transfer(address(0), to, tokenId);
    }

    /**
     * @dev Internal function to burn a specific token
     * Reverts if the token does not exist
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        _clearApproval(owner, tokenId);
        _removeTokenFrom(owner, tokenId);
        emit Transfer(owner, address(0), tokenId);
    }

    /**
     * @dev Internal function to add a token ID to the list of a given address
     * Note that this function is left internal to make ERC721Enumerable possible, but is not
     * intended to be called by custom derived contracts: in particular, it emits no Transfer event.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenTo(address to, uint256 tokenId) internal {
        require(_tokenOwner[tokenId] == address(0));
        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to] = _ownedTokensCount[to].add(1);
    }

    /**
     * @dev Internal function to remove a token ID from the list of a given address
     * Note that this function is left internal to make ERC721Enumerable possible, but is not
     * intended to be called by custom derived contracts: in particular, it emits no Transfer event,
     * and doesn't clear approvals.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFrom(address from, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from);
        _ownedTokensCount[from] = _ownedTokensCount[from].sub(1);
        _tokenOwner[tokenId] = address(0);
    }

    /**
     * @dev Internal function to invoke `onERC721Received` on a target address
     * The call is not executed if the target address is not a contract
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(address from, address to, uint256 tokenId, bytes memory _data) internal returns (bool) {
        if (!to.isContract()) {
            return true;
        }

        bytes4 retval = IERC721Receiver(to).onERC721Received(msg.sender, from, tokenId, _data);
        return (retval == _ERC721_RECEIVED);
    }

    /**
     * @dev Private function to clear current approval of a given token ID
     * Reverts if the given address is not indeed the owner of the token
     * @param owner owner of the token
     * @param tokenId uint256 ID of the token to be transferred
     */
    function _clearApproval(address owner, uint256 tokenId) private {
        require(ownerOf(tokenId) == owner);
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IERC721Enumerable.sol

pragma solidity 0.4.25;

/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
contract IERC721Enumerable is IERC721 {
    function totalSupply() public view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256 tokenId);

    function tokenByIndex(uint256 index) public view returns (uint256);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/ERC721Enumerable.sol

pragma solidity 0.4.25;



/**
 * @title ERC-721 Non-Fungible Token with optional enumeration extension logic
 * @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
contract ERC721Enumerable is ERC165, ERC721, IERC721Enumerable {
    // Mapping from owner to list of owned token IDs
    mapping(address => uint256[]) private _ownedTokens;

    // Mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    // Array with all token ids, used for enumeration
    uint256[] private _allTokens;

    // Mapping from token id to position in the allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    bytes4 private constant _InterfaceId_ERC721Enumerable = 0x780e9d63;
    /**
     * 0x780e9d63 ===
     *     bytes4(keccak256('totalSupply()')) ^
     *     bytes4(keccak256('tokenOfOwnerByIndex(address,uint256)')) ^
     *     bytes4(keccak256('tokenByIndex(uint256)'))
     */

    /**
     * @dev Constructor function
     */
    constructor () public {
        // register the supported interface to conform to ERC721 via ERC165
        _registerInterface(_InterfaceId_ERC721Enumerable);
    }

    /**
     * @dev Gets the token ID at a given index of the tokens list of the requested owner
     * @param owner address owning the tokens list to be accessed
     * @param index uint256 representing the index to be accessed of the requested tokens list
     * @return uint256 token ID at the given index of the tokens list owned by the requested address
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view returns (uint256) {
        require(index < balanceOf(owner));
        return _ownedTokens[owner][index];
    }

    /**
     * @dev Gets the total amount of tokens stored by the contract
     * @return uint256 representing the total amount of tokens
     */
    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }

    /**
     * @dev Gets the token ID at a given index of all the tokens in this contract
     * Reverts if the index is greater or equal to the total number of tokens
     * @param index uint256 representing the index to be accessed of the tokens list
     * @return uint256 token ID at the given index of the tokens list
     */
    function tokenByIndex(uint256 index) public view returns (uint256) {
        require(index < totalSupply());
        return _allTokens[index];
    }

    /**
     * @dev Internal function to add a token ID to the list of a given address
     * This function is internal due to language limitations, see the note in ERC721.sol.
     * It is not intended to be called by custom derived contracts: in particular, it emits no Transfer event.
     * @param to address representing the new owner of the given token ID
     * @param tokenId uint256 ID of the token to be added to the tokens list of the given address
     */
    function _addTokenTo(address to, uint256 tokenId) internal {
        super._addTokenTo(to, tokenId);
        uint256 length = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
        _ownedTokensIndex[tokenId] = length;
    }

    /**
     * @dev Internal function to remove a token ID from the list of a given address
     * This function is internal due to language limitations, see the note in ERC721.sol.
     * It is not intended to be called by custom derived contracts: in particular, it emits no Transfer event,
     * and doesn't clear approvals.
     * @param from address representing the previous owner of the given token ID
     * @param tokenId uint256 ID of the token to be removed from the tokens list of the given address
     */
    function _removeTokenFrom(address from, uint256 tokenId) internal {
        super._removeTokenFrom(from, tokenId);

        // To prevent a gap in the array, we store the last token in the index of the token to delete, and
        // then delete the last slot.
        uint256 tokenIndex = _ownedTokensIndex[tokenId];
        uint256 lastTokenIndex = _ownedTokens[from].length.sub(1);
        uint256 lastToken = _ownedTokens[from][lastTokenIndex];

        _ownedTokens[from][tokenIndex] = lastToken;
        // This also deletes the contents at the last position of the array
        _ownedTokens[from].length--;

        // Note that this will handle single-element arrays. In that case, both tokenIndex and lastTokenIndex are going to
        // be zero. Then we can make sure that we will remove tokenId from the ownedTokens list since we are first swapping
        // the lastToken to the first position, and then dropping the element placed in the last position of the list

        _ownedTokensIndex[tokenId] = 0;
        _ownedTokensIndex[lastToken] = tokenIndex;
    }

    /**
     * @dev Internal function to mint a new token
     * Reverts if the given token ID already exists
     * @param to address the beneficiary that will own the minted token
     * @param tokenId uint256 ID of the token to be minted by the msg.sender
     */
    function _mint(address to, uint256 tokenId) internal {
        super._mint(to, tokenId);

        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    /**
     * @dev Internal function to burn a specific token
     * Reverts if the token does not exist
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        // Reorg all tokens array
        uint256 tokenIndex = _allTokensIndex[tokenId];
        uint256 lastTokenIndex = _allTokens.length.sub(1);
        uint256 lastToken = _allTokens[lastTokenIndex];

        _allTokens[tokenIndex] = lastToken;
        _allTokens[lastTokenIndex] = 0;

        _allTokens.length--;
        _allTokensIndex[tokenId] = 0;
        _allTokensIndex[lastToken] = tokenIndex;
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IERC721Metadata.sol

pragma solidity 0.4.25;

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
contract IERC721Metadata is IERC721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/ERC721Metadata.sol

pragma solidity 0.4.25;



contract ERC721Metadata is ERC165, ERC721, IERC721Metadata {
    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    bytes4 private constant InterfaceId_ERC721Metadata = 0x5b5e139f;
    /**
     * 0x5b5e139f ===
     *     bytes4(keccak256('name()')) ^
     *     bytes4(keccak256('symbol()')) ^
     *     bytes4(keccak256('tokenURI(uint256)'))
     */

    /**
     * @dev Constructor function
     */
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        // register the supported interfaces to conform to ERC721 via ERC165
        _registerInterface(InterfaceId_ERC721Metadata);
    }

    /**
     * @dev Gets the token name
     * @return string representing the token name
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Gets the token symbol
     * @return string representing the token symbol
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns an URI for a given token ID
     * Throws if the token ID does not exist. May return an empty string.
     * @param tokenId uint256 ID of the token to query
     */
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId));
        return _tokenURIs[tokenId];
    }

    /**
     * @dev Internal function to set the token URI for a given token
     * Reverts if the token ID does not exist
     * @param tokenId uint256 ID of the token to set its URI
     * @param uri string URI to assign
     */
    function _setTokenURI(uint256 tokenId, string memory uri) internal {
        require(_exists(tokenId));
        _tokenURIs[tokenId] = uri;
    }

    /**
     * @dev Internal function to burn a specific token
     * Reverts if the token does not exist
     * @param owner owner of the token to burn
     * @param tokenId uint256 ID of the token being burned by the msg.sender
     */
    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/TBoxToken.sol

pragma solidity 0.4.25;



/**
 * @title TBoxClassic Token
 * This implementation includes all the required and some optional functionality of the ERC721 standard
 * Moreover, it includes approve all functionality using operator terminology
 * @dev see https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
contract TBoxToken is ERC721, ERC721Enumerable, ERC721Metadata {
    constructor (string memory name, string memory symbol) ERC721Metadata(name, symbol) public {}
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/ISettings.sol

pragma solidity 0.4.25;


/// @title ISettings
/// @dev Interface for getting the data from settings contract.
interface ISettings {
    function oracleAddress() external view returns(address);
    function minDeposit() external view returns(uint256);
    function sysFee() external view returns(uint256);
    function userFee() external view returns(uint256);
    function ratio() external view returns(uint256);
    function globalTargetCollateralization() external view returns(uint256);
    function tmvAddress() external view returns(uint256);
    function maxStability() external view returns(uint256);
    function minStability() external view returns(uint256);
    function gasPriceLimit() external view returns(uint256);
    function isFeeManager(address account) external view returns (bool);
    function tBoxManager() external view returns(address);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IToken.sol

pragma solidity 0.4.25;


/// @title IToken
/// @dev Interface for interaction with the TMV token contract.
interface IToken {
    function burnLogic(address from, uint256 value) external;
    function balanceOf(address who) external view returns (uint256);
    function mint(address to, uint256 value) external returns (bool);
    function totalSupply() external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 tokenId) external;
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/helpers/IOracle.sol

pragma solidity 0.4.25;


/// @title IOracle
/// @dev Interface for getting the data from the oracle contract.
interface IOracle {
    function ethUsdPrice() external view returns(uint256);
}

// File: ../sc_datasets/DAppSCAN/Coinfabrik-Timvi Smart Contract Audit/Timvi-master/contracts/TBoxManager.sol

pragma solidity 0.4.25;




/// @title TBoxManager
contract TBoxManager is TBoxToken {

    // Total packed Ether
    uint256 public globalETH;

    // Precision using for USD and commission
    uint256 public precision = 100000;

    // The address of the system settings contract
    ISettings public settings;

    /// @dev An array containing the Boxes struct for all Boxes in existence. The ID
    ///  of each Box is actually an index into this array.
    Box[] public boxes;

    /// @dev The main Box struct. Every Box in TimviSystem is represented by a copy
    ///  of this structure.
    struct Box {
        // The collateral Ether amount in wei
        uint256     collateral;
        // The number of TMV withdrawn
        uint256     tmvReleased;
    }

    /// @dev The Created event is fired whenever a new Box comes into existence. This includes
    ///  any time a Box is created through the create method.
    event Created(uint256 indexed id, address owner, uint256 collateral, uint256 tmvReleased);

    /// @dev The Closed event is fired whenever a Box is closed. Obviously, this includes
    ///  any time a Box is closed through the close method, but it is also called when
    //   a Box is closed through the closeDust method.
    event Closed(uint256 indexed id, address indexed owner, address indexed closer);

    /// @dev The Capitalized event is fired whenever a Box is capitalized.
    event Capitalized(uint256 indexed id, address indexed owner, address indexed who, uint256 tmvAmount, uint256 totalEth, uint256 userEth);

    /// @dev The EthWithdrawn event is fired whenever Ether is withdrawn from a Box
    ///  using withdrawEth method.
    event EthWithdrawn(uint256 indexed id, uint256 value, address who);

    /// @dev The TmvWithdrawn event is fired whenever TMV is withdrawn from a Box
    ///  using withdrawTmv method.
    event TmvWithdrawn(uint256 indexed id, uint256 value, address who);

    /// @dev The EthAdded event is fired whenever Ether is added to a Box
    ///  using addEth method.
    event EthAdded(uint256 indexed id, uint256 value, address who);

    /// @dev The TmvAdded event is fired whenever TMV is added to a Box
    ///  using addTmv method.
    event TmvAdded(uint256 indexed id, uint256 value, address who);

    /// @dev Defends against front-running attacks.
    modifier validTx() {
        require(tx.gasprice <= settings.gasPriceLimit(), "Gas price is greater than allowed");
        _;
    }

    /// @dev Throws if called by any account other than the owner.
    modifier onlyAdmin() {
        require(settings.isFeeManager(msg.sender), "You have no access");
        _;
    }

    /// @dev Throws if Box with specified id does not exist.
    modifier onlyExists(uint256 _id) {
        require(_exists(_id), "Box does not exist");
        _;
    }

    /// @dev Access modifier for token owner-only functionality.
    modifier onlyApprovedOrOwner(uint256 _id) {
        require(_isApprovedOrOwner(msg.sender, _id), "Box isn't your");
        _;
    }

    /// @dev The constructor sets ERC721 token name and symbol.
    /// @param _settings The address of the system settings contract.
    constructor(address _settings) TBoxToken("TBoxToken", "TBX") public {
        settings = ISettings(_settings);
    }

    /// @notice The funds are safe.
    /// @dev Creates Box with max collateral percent.
    function() external payable {
        // Redirect to the create method with no tokens to withdraw
        create(0);
    }

    /// @dev Withdraws system fee.
    function withdrawFee(address _beneficiary) external onlyAdmin {
        require(_beneficiary != address(0), "Zero address, be careful");

        // Fee is the difference between the contract balance and
        // amount of Ether used in the entire system collateralization
        uint256 _fees = address(this).balance.sub(globalETH);

        // Check that the fee is collected
        require(_fees > 0, "There is no available fees");

        // Transfer fee to provided address
        _beneficiary.transfer(_fees);
    }

    /// @dev Checks possibility of the issue of the specified token amount
    ///  for provided Ether collateral and creates new Box
    /// @param _tokensToWithdraw Number of tokens to withdraw
    /// @return New Box ID.
    function create(uint256 _tokensToWithdraw) public payable validTx returns (uint256) {
        // Check that msg.value isn't smaller than minimum deposit
        require(msg.value >= settings.minDeposit(), "Deposit is very small");

        // Calculate collateralization when tokens are needed
        if (_tokensToWithdraw > 0) {

            // The number of tokens when collateralization is high
            uint256 _tokenLimit = overCapWithdrawableTmv(msg.value);

            // The number of tokens that can be safely withdrawn from the system
            uint256 _maxGlobal = globalWithdrawableTmv(msg.value);

            // Determine the higher number of tokens
            if (_tokenLimit > _maxGlobal) {
                _tokenLimit = _maxGlobal;
            }

            // The number of tokens that can be withdrawn anyway
            uint256 _local = defaultWithdrawableTmv(msg.value);

            // Determine the higher number of tokens
            if (_tokenLimit < _local) {
                _tokenLimit = _local;
            }

            // You can only withdraw available amount
            require(_tokensToWithdraw <= _tokenLimit, "Token amount is more than available");

            // Mint TMV tokens to the Box creator
            IToken(settings.tmvAddress()).mint(msg.sender, _tokensToWithdraw);
        }

        // The id of the new Box
        uint256 _id = boxes.push(Box(msg.value, _tokensToWithdraw)).sub(1);

        // Increase global Ether counter
        globalETH = globalETH.add(msg.value);

        // Mint TBX token to the Box creator
        _mint(msg.sender, _id);

        // Fire the event
        emit Created(_id, msg.sender, msg.value, _tokensToWithdraw);

        // return the new Box's ID
        return _id;
    }

    /// @dev Allows the owner or approved user of the Box to close one by burning the
    ///  required number of tokens and return the Box's collateral.
    /// @param _id A Box ID to close.
    function close(uint256 _id) external onlyApprovedOrOwner(_id) {

        // Address of the owner of the Box
        address _owner = _tokenOwner[_id];

        // Burn needed number of tokens
        uint256 _tokensNeed = boxes[_id].tmvReleased;
        _burnTMV(msg.sender, _tokensNeed);

        // Grab a reference to the Box's collateral in storage
        uint256 _collateral = boxes[_id].collateral;

        // burn Box token
        _burn(_owner, _id);

        // Removes Box
        delete boxes[_id];

        // Send the Box's collateral to the person who made closing happen
        msg.sender.transfer(_collateral);

        // Decrease global Ether counter
        globalETH = globalETH.sub(_collateral);

        // Fire the event
        emit Closed(_id, _owner, msg.sender);
    }

    /// @notice This allows you not to be tied to the current ETH/USD rate.
    /// @dev Allows the user to capitalize a Box with the maximum current amount.
    /// @param _id A Box ID to capitalize.
    function capitalizeMax(uint256 _id) external {
        capitalize(_id, maxCapAmount(_id));
    }

    /// @dev Allows the user to capitalize a Box with specified number of tokens.
    /// @param _id A Box ID to capitalize.
    /// @param _tmv Specified number of tokens to capitalize.
    function capitalize(uint256 _id, uint256 _tmv) public validTx {

        // The maximum number of tokens for which Box can be capitalized
        uint256 _maxCapAmount = maxCapAmount(_id);

        // Check the number of tokens
        require(_tmv <= _maxCapAmount && _tmv >= 10 ** 17, "Tokens amount out of range");

        // Decrease Box TMV withdrawn counter
        boxes[_id].tmvReleased = boxes[_id].tmvReleased.sub(_tmv);

        // Calculate the Ether equivalent of tokens according to the logic
        // where 1 TMV is equal to 1 USD
        uint256 _equivalentETH = _tmv.mul(precision).div(rate());

        // Calculate system fee
        uint256 _fee = _tmv.mul(settings.sysFee()).div(rate());

        // Calculate user bonus
        uint256 _userReward = _tmv.mul(settings.userFee()).div(rate());

        // Decrease Box's collateral amount
        boxes[_id].collateral = boxes[_id].collateral.sub(_fee.add(_userReward).add(_equivalentETH));

        // Decrease global Ether counter
        globalETH = globalETH.sub(_fee.add(_userReward).add(_equivalentETH));

        // burn Box token
        _burnTMV(msg.sender, _tmv);

        // Send the Ether equivalent & user benefit to the person who made capitalization happen.
        msg.sender.transfer(_equivalentETH.add(_userReward));

        // Fire the event
        emit Capitalized(_id, ownerOf(_id), msg.sender, _tmv, _equivalentETH.add(_userReward).add(_fee), _equivalentETH.add(_userReward));
    }

    /// @notice This allows you not to be tied to the current ETH/USD rate.
    /// @dev Allows an owner or approved user of the Box to withdraw maximum amount
    ///  of Ether from the Box.
    /// @param _id A Box ID.
    function withdrawEthMax(uint256 _id) external {
        withdrawEth(_id, withdrawableEth(_id));
    }

    /// @dev Allows an owner or approved user of the Box to withdraw specified amount
    ///  of Ether from the Box.
    /// @param _id A Box ID.
    /// @param _amount The number of Ether to withdraw.
    function withdrawEth(uint256 _id, uint256 _amount) public onlyApprovedOrOwner(_id) validTx {
        require(_amount > 0, "Withdrawing zero");

        require(_amount <= withdrawableEth(_id), "You can't withdraw so much");

        // Decrease Box's collateral amount
        boxes[_id].collateral = boxes[_id].collateral.sub(_amount);

        // Decrease global Ether counter
        globalETH = globalETH.sub(_amount);

        // Send the Ether to the person who made capitalization happen
        msg.sender.transfer(_amount);

        // Fire the event
        emit EthWithdrawn(_id, _amount, msg.sender);
    }

    /// @notice This allows you not to be tied to the current ETH/USD rate.
    /// @dev Allows an owner or approved user of the Box to withdraw maximum number
    ///  of TMV tokens from the Box.
    /// @param _id A Box ID.
    function withdrawTmvMax(uint256 _id) external onlyApprovedOrOwner(_id) {
        withdrawTmv(_id, boxWithdrawableTmv(_id));
    }

    /// @dev Allows an owner or approved user of the Box to withdraw specified number
    ///  of TMV tokens from the Box.
    /// @param _id A Box ID.
    /// @param _amount The number of tokens to withdraw.
    function withdrawTmv(uint256 _id, uint256 _amount) public onlyApprovedOrOwner(_id) validTx {
        require(_amount > 0, "Withdrawing zero");

        // Check the number of tokens
        require(_amount <= boxWithdrawableTmv(_id), "You can't withdraw so much");

        // Increase Box TMV withdrawn counter
        boxes[_id].tmvReleased = boxes[_id].tmvReleased.add(_amount);

        // Mints tokens to the person who made withdrawing
        IToken(settings.tmvAddress()).mint(msg.sender, _amount);

        // Fire the event
        emit TmvWithdrawn(_id, _amount, msg.sender);
    }

    /// @dev Allows anyone to add Ether to a Box.
    /// @param _id A Box ID.
    function addEth(uint256 _id) external payable onlyExists(_id) {
        require(msg.value > 0, "Don't add 0");

        // Increase Box collateral
        boxes[_id].collateral = boxes[_id].collateral.add(msg.value);

        // Increase global Ether counter
        globalETH = globalETH.add(msg.value);

        // Fire the event
        emit EthAdded(_id, msg.value, msg.sender);
    }

    /// @dev Allows anyone to add TMV to a Box.
    /// @param _id A Box ID.
    /// @param _amount The number of tokens to add.
    function addTmv(uint256 _id, uint256 _amount) external onlyExists(_id) {
        require(_amount > 0, "Don't add 0");

        // Check the number of tokens
        require(_amount <= boxes[_id].tmvReleased, "Too much tokens");

        // Removes added tokens from the collateralization
        _burnTMV(msg.sender, _amount);
        boxes[_id].tmvReleased = boxes[_id].tmvReleased.sub(_amount);

        // Fire the event
        emit TmvAdded(_id, _amount, msg.sender);
    }

    /// @dev Allows anyone to close Box with collateral amount smaller than 3 USD.
    ///  The person who made closing happen will benefit like capitalization.
    /// @param _id A Box ID.
    function closeDust(uint256 _id) external onlyExists(_id) validTx {
        // Check collateral percent of the Box
        require(collateralPercent(_id) >= settings.minStability(), "This Box isn't collapsable");

        // Check collateral amount of the Box
        require(boxes[_id].collateral.mul(rate()) < precision.mul(3).mul(10 ** 18), "It's only possible to collapse dust");

        // Burn needed TMV amount to close
        uint256 _tmvReleased = boxes[_id].tmvReleased;
        _burnTMV(msg.sender, _tmvReleased);

        uint256 _collateral = boxes[_id].collateral;

        // Calculate the Ether equivalent of tokens according to the logic
        // where 1 TMV is equal to 1 USD
        uint256 _eth = _tmvReleased.mul(precision).div(rate());

        // Calculate user bonus
        uint256 _userReward = _tmvReleased.mul(settings.userFee()).div(rate());

        // The owner of the Box
        address _owner = ownerOf(_id);

        // Remove a Box
        delete boxes[_id];

        // Burn Box token
        _burn(_owner, _id);

        // Send the Ether equivalent & user benefit to the person who made closing happen
        msg.sender.transfer(_eth.add(_userReward));

        // Decrease global Ether counter
        globalETH = globalETH.sub(_collateral);

        // Fire the event
        emit Closed(_id, _owner, msg.sender);
    }

    /// @dev Burns specified number of TMV tokens.
    function _burnTMV(address _from, uint256 _amount) internal {
        if (_amount > 0) {
            require(IToken(settings.tmvAddress()).balanceOf(_from) >= _amount, "You don't have enough tokens");
            IToken(settings.tmvAddress()).burnLogic(_from, _amount);
        }
    }

    /// @dev Returns current oracle ETH/USD price with precision.
    function rate() public view returns(uint256) {
        return IOracle(settings.oracleAddress()).ethUsdPrice();
    }

    /// @dev Given a Box ID, returns a number of tokens that can be withdrawn.
    function boxWithdrawableTmv(uint256 _id) public view onlyExists(_id) returns(uint256) {
        Box memory box = boxes[_id];

        // Number of tokens that can be withdrawn for Box's collateral
        uint256 _amount = withdrawableTmv(box.collateral);

        if (box.tmvReleased >= _amount) {
            return 0;
        }

        // Return withdrawable rest
        return _amount.sub(box.tmvReleased);
    }

    /// @dev Given a Box ID, returns an amount of Ether that can be withdrawn.
    function withdrawableEth(uint256 _id) public view onlyExists(_id) returns(uint256) {

        // Amount of Ether that is not used in collateralization
        uint256 _avlbl = _freeEth(_id);
        // Return available Ether to withdraw
        if (_avlbl == 0) {
            return 0;
        }
        uint256 _rest = boxes[_id].collateral.sub(_avlbl);
        if (_rest < settings.minDeposit()) {
            return boxes[_id].collateral.sub(settings.minDeposit());
        }
        else return _avlbl;
    }

    /// @dev Given a Box ID, returns amount of ETH that is not used in collateralization.
    function _freeEth(uint256 _id) internal view returns(uint256) {
        // Grab a reference to the Box
        Box memory box = boxes[_id];

        // When there are no tokens withdrawn
        if (box.tmvReleased == 0) {
            return box.collateral;
        }

        // The amount of Ether that can be safely withdrawn from the system
        uint256 _maxGlobal = globalWithdrawableEth();
        uint256 _globalAvailable;

        if (_maxGlobal > 0) {
            // The amount of Ether backing the tokens when the system is overcapitalized
            uint256 _need = overCapFrozenEth(box.tmvReleased);
            if (box.collateral > _need) {
                // Free Ether amount when the system is overcapitalized
                uint256 _free = box.collateral.sub(_need);
                if (_free > _maxGlobal) {
                    // Store available amount when Box available Ether amount
                    // is more than global available
                    _globalAvailable = _maxGlobal;
                }

                // Return available amount of Ether to withdraw when the Box withdrawable
                // amount of Ether is smaller than global withdrawable amount of Ether
                else return _free;
            }
        }

        // The amount of Ether backing the tokens by default
        uint256 _frozen = defaultFrozenEth(box.tmvReleased);
        if (box.collateral > _frozen) {
            // Define the biggest number and return available Ether amount
            uint256 _localAvailable = box.collateral.sub(_frozen);
            return (_localAvailable > _globalAvailable) ? _localAvailable : _globalAvailable;
        } else {
            // Return available Ether amount
            return _globalAvailable;
        }

    }

    /// @dev Given a Box ID, returns collateral percent.
    function collateralPercent(uint256 _id) public view onlyExists(_id) returns(uint256) {
        Box memory box = boxes[_id];
        if (box.tmvReleased == 0) {
            return 10**27; //some unreachable number
        }
        uint256 _ethCollateral = box.collateral;
        // division by 100 is not necessary because to get the percent you need to multiply by 100
        return _ethCollateral.mul(rate()).div(box.tmvReleased);
    }

    /// @dev Checks if a given address currently has approval for a particular Box.
    /// @param _spender the address we are confirming Box is approved for.
    /// @param _tokenId Box ID.
    function isApprovedOrOwner(address _spender, uint256 _tokenId) external view returns (bool) {
        return _isApprovedOrOwner(_spender, _tokenId);
    }

    /// @dev Returns the global collateralization percent.
    function globalCollateralization() public view returns (uint256) {
        uint256 _supply = IToken(settings.tmvAddress()).totalSupply();
        if (_supply == 0) {
            return settings.globalTargetCollateralization();
        }
        return globalETH.mul(rate()).div(_supply);
    }

    /// @dev Returns the number of tokens that can be safely withdrawn from the system.
    function globalWithdrawableTmv(uint256 _value) public view returns (uint256) {
        uint256 _supply = IToken(settings.tmvAddress()).totalSupply();
        if (globalCollateralization() <= settings.globalTargetCollateralization()) {
            return 0;
        }
        uint256 _totalBackedTmv = defaultWithdrawableTmv(globalETH.add(_value));
        return _totalBackedTmv.sub(_supply);
    }

    /// @dev Returns Ether amount that can be safely withdrawn from the system.
    function globalWithdrawableEth() public view returns (uint256) {
        uint256 _supply = IToken(settings.tmvAddress()).totalSupply();
        if (globalCollateralization() <= settings.globalTargetCollateralization()) {
            return 0;
        }
        uint256 _need = defaultFrozenEth(_supply);
        return globalETH.sub(_need);
    }

    /// @dev Returns the number of tokens that can be withdrawn
    ///  for the specified collateral amount by default.
    function defaultWithdrawableTmv(uint256 _collateral) public view returns (uint256) {
        uint256 _num = _collateral.mul(rate());
        uint256 _div = settings.globalTargetCollateralization();
        return _num.div(_div);
    }

    /// @dev Returns the number of tokens that can be withdrawn
    ///  for the specified collateral amount when the system is overcapitalized.
    function overCapWithdrawableTmv(uint256 _collateral) public view returns (uint256) {
        uint256 _num = _collateral.mul(rate());
        uint256 _div = settings.ratio();
        return _num.div(_div);
    }

    /// @dev Returns Ether amount backing the specified number of tokens by default.
    function defaultFrozenEth(uint256 _supply) public view returns (uint256) {
        return _supply.mul(settings.globalTargetCollateralization()).div(rate());
    }


    /// @dev Returns Ether amount backing the specified number of tokens
    ///  when the system is overcapitalized.
    function overCapFrozenEth(uint256 _supply) public view returns (uint256) {
        return _supply.mul(settings.ratio()).div(rate());
    }


    /// @dev Returns the number of TMV that can capitalize the specified Box.
    function maxCapAmount(uint256 _id) public view onlyExists(_id) returns (uint256) {
        uint256 _colP = collateralPercent(_id);
        require(_colP >= settings.minStability() && _colP < settings.maxStability(), "It's only possible to capitalize toxic Boxes");

        Box memory box = boxes[_id];

        uint256 _num = box.tmvReleased.mul(settings.ratio()).sub(box.collateral.mul(rate()));
        uint256 _div = settings.ratio().sub(settings.minStability());
        return _num.div(_div);
    }

    /// @dev Returns the number of tokens that can be actually withdrawn
    ///  for the specified collateral.
    function withdrawableTmv(uint256 _collateral) public view returns(uint256) {
        uint256 _amount = overCapWithdrawableTmv(_collateral);
        uint256 _maxGlobal = globalWithdrawableTmv(0);
        if (_amount > _maxGlobal) {
            _amount = _maxGlobal;
        }
        uint256 _local = defaultWithdrawableTmv(_collateral);
        if (_amount < _local) {
            _amount = _local;
        }
        return _amount;
    }

    /// @dev Returns the collateral percentage for which tokens can be withdrawn
    ///  for the specified collateral.
    function withdrawPercent(uint256 _collateral) external view returns(uint256) {
        uint256 _amount = overCapWithdrawableTmv(_collateral);
        uint256 _maxGlobal = globalWithdrawableTmv(_collateral);
        if (_amount > _maxGlobal) {
            _amount = _maxGlobal;
        }
        uint256 _local = defaultWithdrawableTmv(_collateral);
        if (_amount < _local) {
            _amount = _local;
        }
        return _collateral.mul(rate()).div(_amount);
    }
}
