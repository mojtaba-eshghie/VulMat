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

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/contracts/openzeppelin-solidity/contracts/ECRecovery.sol

pragma solidity ^0.4.24;


/**
 * @title Elliptic curve signature operations
 * @dev Based on https://gist.github.com/axic/5b33912c6f61ae6fd96d6c4a47afde6d
 * TODO Remove this library once solidity supports passing a signature to ecrecover.
 * See https://github.com/ethereum/solidity/issues/864
 */

library ECRecovery {

  /**
   * @dev Recover signer address from a message by using their signature
   * @param _hash bytes32 message, the hash is the signed message. What is recovered is the signer address.
   * @param _sig bytes signature, the signature is generated using web3.eth.sign()
   */
  function recover(bytes32 _hash, bytes _sig)
    internal
    pure
    returns (address)
  {
    bytes32 r;
    bytes32 s;
    uint8 v;

    // Check the signature length
    if (_sig.length != 65) {
      return (address(0));
    }

    // Divide the signature in r, s and v variables
    // ecrecover takes the signature parameters, and the only way to get them
    // currently is to use assembly.
    // solium-disable-next-line security/no-inline-assembly
    assembly {
      r := mload(add(_sig, 32))
      s := mload(add(_sig, 64))
      v := byte(0, mload(add(_sig, 96)))
    }

    // Version of signature should be 27 or 28, but 0 and 1 are also possible versions
    if (v < 27) {
      v += 27;
    }

    // If the version is correct return the signer address
    if (v != 27 && v != 28) {
      return (address(0));
    } else {
      // solium-disable-next-line arg-overflow
      return ecrecover(_hash, v, r, s);
    }
  }

  /**
   * toEthSignedMessageHash
   * @dev prefix a bytes32 value with "\x19Ethereum Signed Message:"
   * and hash the result
   */
  function toEthSignedMessageHash(bytes32 _hash)
    internal
    pure
    returns (bytes32)
  {
    // 32 is the length in bytes of hash,
    // enforced by the type signature above
    return keccak256(
      abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash)
    );
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

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/Enigma.sol

pragma solidity ^0.4.24;




contract IERC20 {
    function balanceOf(address who) public view returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
    function allowance(address owner, address spender) public view returns (uint256);
    function transferFrom(address from, address to, uint256 value) public returns (bool);
    function approve(address spender, uint256 value) public returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract Enigma {
    using SafeMath for uint256;
    using ECRecovery for bytes32;

    // The interface of the deployed ENG ERC20 token contract
    IERC20 public engToken;

    // The data representation of a computation task
    struct Task {
        address dappContract;
        TaskStatus status;
        string callable;
        bytes callableArgs;
        string callback;
        address worker;
        bytes sig;
        uint256 reward;
        uint256 blockNumber;
    }
    enum TaskStatus {InProgress, Executed}

    enum ReturnValue {Ok, Error}

    /**
    * The signer address of the principal node
    * This must be set when deploying the contract and remains immutable
    * Since the signer address is derived from the public key of an
    * SGX enclave, this ensures that the principal node cannot be tempered
    * with or replaced.
    */
    address principal;

    // The data representation of a worker (or node)
    struct Worker {
        address signer;
        uint8 status; // Uninitialized: 0; Active: 1; Inactive: 2
        bytes report; // Decided to store this as one  RLP encoded attribute for easier external storage in the future
        uint256 balance;
    }

    /**
    * The data representation of the worker parameters used as input for
    * the worker selection algorithm
    */
    struct WorkersParams {
        uint256 firstBlockNumber;
        address[] workerAddresses;
        uint256 seed;
    }

    /**
    * The last 5 worker parameters
    * We keep a collection of worker parameters to account for latency issues.
    * A computation task might be conceivably given out at a certain block number
    * but executed at a later block in a different epoch. It follows that
    * the contract must have access to the worker parameters effective when giving
    * out the task, otherwise the selected worker would not match. We calculated
    * that keeping the last 5 items should be more than enough to account for
    * all latent tasks. Tasks results will be rejected past this limit.
    */
    WorkersParams[5] workersParams;

    // An address-based index of all registered worker
    address[] public workerAddresses;

    // A registry of all registered workers with their attributes
    mapping(address => Worker) public workers;
    // A registry of all active and historical tasks with their attributes
    // TODO: do we keep tasks forever? if not, when do we delete them?
    mapping(bytes32 => Task) public tasks;

    // The events emitted by the contract
    event Register(address custodian, address signer, bool _success);
    event ValidatedSig(bytes sig, bytes32 hash, address workerAddr, bool _success);
    event CommitResults(address dappContract, address worker, bytes sig, uint reward, bool _success);
    event WorkersParameterized(uint256 seed, address[] workers, bool _success);
    event ComputeTask(
        address indexed dappContract,
        bytes32 indexed taskId,
        string callable,
        bytes callableArgs,
        string callback,
        uint256 fee,
        bytes32[] preprocessors,
        uint256 blockNumber,
        bool _success
    );

    constructor(address _tokenAddress, address _principal) public {
        engToken = IERC20(_tokenAddress);
        principal = _principal;
    }

    /**
    * Checks if the custodian wallet is registered as a worker
    *
    * @param user The custodian address of the worker
    */
    modifier workerRegistered(address user) {
        Worker memory worker = workers[user];
        require(worker.status > 0, "Unregistered worker.");
        _;
    }

    /**
    * Registers a new worker of change the signer parameters of an existing
    * worker. This should be called by every worker (and the principal)
    * node in order to receive tasks.
    *
    * @param signer The signer address, derived from the enclave public key
    * @param report The RLP encoded report returned by the IAS
    */
    function register(address signer, bytes report)
        public
        payable
        returns (ReturnValue)
    {
        // TODO: consider exit if both signer and custodian as matching
        // If the custodian is not already register, we add an index entry
        if (workers[msg.sender].signer == 0x0) {
            uint index = workerAddresses.length;
            workerAddresses.length++;
            workerAddresses[index] = msg.sender;
        }

        // Set the custodian attributes
        workers[msg.sender].signer = signer;
        workers[msg.sender].balance = msg.value;
        workers[msg.sender].report = report;
        workers[msg.sender].status = 1;

        emit Register(msg.sender, signer, true);

        return ReturnValue.Ok;
    }

    /**
    * Generates a unique task id
    *
    * @param dappContract The address of the deployed contract containing the callable method
    * @param callable The signature (as defined by the Ethereum ABI) of the function to compute
    * @param callableArgs The RLP serialized arguments of the callable function
    * @param blockNumber The current block number
    * @return The task id
    */
    function generateTaskId(address dappContract, string callable, bytes callableArgs, uint256 blockNumber)
        public
        pure
        returns (bytes32)
    {
        bytes32 hash = keccak256(abi.encodePacked(dappContract, callable, callableArgs, blockNumber));
        return hash;
    }

    /**
    * Give out a computation task to the network
    *
    * @param dappContract The address of the deployed contract containing the callable method
    * @param callable The signature (as defined by the Ethereum ABI) of the function to compute
    * @param callableArgs The RLP serialized arguments of the callable function
    * @param callback The signature of the function to call back with the results
    * @param fee The computation fee in ENG
    * @param preprocessors A list of preprocessors to run and inject as argument of callable
    * @param blockNumber The current block number
    */
    function compute(
        address dappContract,
        string callable,
        bytes callableArgs,
        string callback,
        uint256 fee,
        bytes32[] preprocessors,
        uint256 blockNumber
    )
        public
        returns (ReturnValue)
    {
        // TODO: Add a multiplier to the fee (like ETH => wei) in order to accept smaller denominations
        bytes32 taskId = generateTaskId(dappContract, callable, callableArgs, blockNumber);
        require(tasks[taskId].dappContract == 0x0, "Task with the same taskId already exist");

        tasks[taskId].reward = fee;
        tasks[taskId].callable = callable;
        tasks[taskId].callableArgs = callableArgs;
        tasks[taskId].callback = callback;
        tasks[taskId].status = TaskStatus.InProgress;
        tasks[taskId].dappContract = dappContract;
        tasks[taskId].blockNumber = blockNumber;

        // Emit the ComputeTask event which each node is watching for
        emit ComputeTask(
            dappContract,
            taskId,
            callable,
            callableArgs,
            callback,
            fee,
            preprocessors,
            blockNumber,
            true
        );

        // Transferring before emitting does not work
        // TODO: check the allowance first
        engToken.transferFrom(msg.sender, this, fee);

        return ReturnValue.Ok;
    }

    // Verify the task results signature
    function verifyCommitSig(Task task, bytes data, bytes sig)
        internal
        returns (address)
    {
        // Recreating a data hash to validate the signature
        bytes memory code = GetCode.at(task.dappContract);

        // Build a hash to validate that the I/Os are matching
        bytes32 hash = keccak256(abi.encodePacked(task.callableArgs, data, code));

        // The worker address is not a real Ethereum wallet address but
        // one generated from its signing key
        address workerAddr = hash.recover(sig);

        emit ValidatedSig(sig, hash, workerAddr, true);
        return workerAddr;
    }

    // Execute the encoded function in the specified contract
    function executeCall(address to, uint256 value, bytes data)
        internal
        returns (bool success)
    {
        assembly {
            success := call(gas, to, value, add(data, 0x20), mload(data), 0, 0)
        }
    }

    /**
    * Commit the computation task results on chain
    *
    * @param taskId The reference task id
    * @param data The encoded callback function call (which includes the computation results)
    * @param sig The data signed by the the worker's enclave
    * @param blockNumber The block number which originated the task
    */
    function commitResults(bytes32 taskId, bytes data, bytes sig, uint256 blockNumber)
        public
        workerRegistered(msg.sender)
        returns (ReturnValue)
    {
        // Task must be solved only once
        require(tasks[taskId].status == TaskStatus.InProgress, "Illegal status, task must be in progress.");
        // TODO: run worker selection algo to validate right worker
        require(block.number > blockNumber, "Block number in the future.");

        address sigAddr = verifyCommitSig(tasks[taskId], data, sig);
        require(sigAddr != address(0), "Cannot verify this signature.");
        require(sigAddr == workers[msg.sender].signer, "Invalid signature.");

        // The contract must hold enough fund to distribute reward
        // TODO: validate that the reward matches the opcodes computed
        uint256 reward = tasks[taskId].reward;
        require(reward > 0, "Reward cannot be zero.");

        // Invoking the callback method of the original contract
        require(executeCall(tasks[taskId].dappContract, 0, data), "Unable to invoke the callback");

        // Keep a trace of the task worker and proof
        tasks[taskId].worker = msg.sender;
        tasks[taskId].sig = sig;
        tasks[taskId].status = TaskStatus.Executed;

        // TODO: send directly to the worker's custodian instead
        // Put the reward in the worker's bank
        // He can withdraw later
        Worker storage worker = workers[msg.sender];
        worker.balance = worker.balance.add(reward);

        emit CommitResults(tasks[taskId].dappContract, sigAddr, sig, reward, true);

        return ReturnValue.Ok;
    }

    // Verify the signature submitted while reparameterizing workers
    function verifyParamsSig(uint256 seed, bytes sig)
        internal
        pure
        returns (address)
    {
        bytes32 hash = keccak256(abi.encodePacked(seed));
        address signer = hash.recover(sig);
        return signer;
    }

    /**
    * Reparameterizing workers with a new seed
    * This should be called for each epoch by the Principal node
    *
    * @param seed The random integer generated by the enclave
    * @param sig The random integer signed by the the principal node's enclave
    */
    function setWorkersParams(uint256 seed, bytes sig)
        public
        workerRegistered(msg.sender)
        returns (ReturnValue)
    {
        require(workers[msg.sender].signer == principal, "Only the Principal can update the seed");

        address sigAddr = verifyParamsSig(seed, sig);
        require(sigAddr == principal, "Invalid signature");

        // Create a new workers parameters item for the specified seed.
        // The workers parameters list is a sort of cache, it never grows beyond its limit.
        // If the list is full, the new item will replace the item assigned to the lowest block number.
        uint ti = 0;
        for (uint pi = 0; pi < workersParams.length; pi++) {
            // Find an empty slot in the array, if full use the lowest block number
            if (workersParams[pi].firstBlockNumber == 0) {
                ti = pi;
                break;
            } else if (workersParams[pi].firstBlockNumber < workersParams[ti].firstBlockNumber) {
                ti = pi;
            }
        }
        workersParams[ti].firstBlockNumber = block.number;
        workersParams[ti].seed = seed;

        // Copy the current worker list
        for (uint wi = 0; wi < workerAddresses.length; wi++) {
            if (workerAddresses[wi] != 0x0) {
                workersParams[ti].workerAddresses.length++;
                workersParams[ti].workerAddresses[wi] = workerAddresses[wi];
            }
        }
        emit WorkersParameterized(seed, workerAddresses, true);
        return ReturnValue.Ok;
    }

    // The workers parameters nearest the specified block number
    function getWorkersParamsIndex(uint256 blockNumber)
        internal
        view
        returns (int8)
    {
        int8 ci = - 1;
        for (uint i = 0; i < workersParams.length; i++) {
            if (workersParams[i].firstBlockNumber <= blockNumber && (ci == - 1 || workersParams[i].firstBlockNumber > workersParams[uint(ci)].firstBlockNumber)) {
                ci = int8(i);
            }
        }
        return ci;
    }

    /**
    * The worker parameters corresponding to the specified block number
    *
    * @param blockNumber The reference block number
    */
    function getWorkersParams(uint256 blockNumber)
        public
        view
        returns (uint256, uint256, address[])
    {
        // The workers parameters for a given block number
        int8 idx = getWorkersParamsIndex(blockNumber);
        require(idx != - 1, "No workers parameters entry for specified block number");

        uint index = uint(idx);
        WorkersParams memory _workerParams = workersParams[index];
        address[] memory addrs = filterWorkers(_workerParams.workerAddresses);

        return (_workerParams.firstBlockNumber, _workerParams.seed, addrs);
    }

    // Filter out bad values from a list of worker addresses
    function filterWorkers(address[] addrs)
        internal
        view
        returns (address[])
    {
        // TODO: I don't know why the list contains empty addresses, investigate
        uint cpt = 0;
        for (uint i = 0; i < addrs.length; i++) {
            if (addrs[i] != 0x0 && workers[addrs[i]].signer != principal) {
                cpt++;
            }
        }
        address[] memory _workers = new address[](cpt);
        uint cur = 0;
        for (uint iw = 0; iw < addrs.length; iw++) {
            if (addrs[iw] != 0x0 && workers[addrs[iw]].signer != principal) {
                _workers[cur] = addrs[iw];
                cur++;
            }
        }
        return _workers;
    }

    /**
    * Apply pseudo-randomness to discover the selected worker for the specified task
    *
    * @param blockNumber The reference block number
    * @param taskId The reference task id
    */
    function selectWorker(uint256 blockNumber, bytes32 taskId)
        public
        view
        returns (address)
    {
        (uint256 b, uint256 seed, address[] memory workerArray) = getWorkersParams(blockNumber);
        address[] memory _workers = filterWorkers(workerArray);

        bytes32 hash = keccak256(abi.encodePacked(seed, taskId));
        uint256 index = uint256(hash) % _workers.length;
        return _workers[index];
    }

    /**
    * The RLP encoded report returned by the IAS server
    *
    * @param custodian The worker's custodian address
    */
    function getReport(address custodian)
        public
        view
        workerRegistered(custodian)
        returns (address, bytes)
    {
        // The RLP encoded report and signer's address for the specified worker
        require(workers[custodian].signer != 0x0, "Worker not registered");
        return (workers[custodian].signer, workers[custodian].report);
    }
}

// File: ../sc_datasets/DAppSCAN/Solidified-2Key [14.10.2019]/contracts-de171eb80e9ce1c6566a5d782f0a0549ab0151ad/poc_contracts/2key/TwoKeyVotingContract.sol

// Voting.sol
// Enigma, 2018
// Implement secret voting.

pragma solidity ^0.4.24;

  /* EVENTS */
  event voteCasted(address voter, bytes vote);
  event pollCreated(address creator, uint quorumPercentage, string description, uint votingLength);
  event pollStatusUpdate(bool status);

  /* Determine the current state of a poll */
  enum PollStatus { IN_PROGRESS, TALLY, PASSED, REJECTED }

  /* POLL */
  struct Poll {
    address creator;
    PollStatus status;
    uint quorumPercentage;
    uint yeaVotes;
    uint nayVotes;
    string description;
    address[] voters;
    uint expirationTime;
    mapping(address => Voter) voterInfo;
  }

  /* VOTER */
  struct Voter {
    bool hasVoted;
    bytes vote;
  }

  /* STATE VARIABLES */
  Poll public polls;
  Enigma public enigma;

  /* CONSTRUCTOR */
  constructor(address _token, address _enigma) public {
//    require(_token != 0 && address(token) == 0);
    require(_enigma != 0 && address(enigma) == 0);
    enigma = Enigma(_enigma);
  }

  /* POLL OPERATIONS */

  /*
   * Creates a new poll with a specified quorum percentage.
   */
  function createPoll(uint _quorumPct, string _description, uint _voteLength) public {
    require(_quorumPct <= 100, "Quorum Percentage must be less than or equal to 100%");
    require(_voteLength > 0, "The voting period cannot be 0.");

    polls.creator = msg.sender;
    polls.status = PollStatus.IN_PROGRESS;
    polls.quorumPercentage = _quorumPct;
    polls.expirationTime = now + _voteLength * 1 seconds;
    polls.description = _description;

    emit pollCreated(msg.sender, _quorumPct, _description, _voteLength);
  }

  /*
   * Ends a poll. Only the creator of a given poll can end that poll.
   */
  function endPoll() external  {
    require(msg.sender == polls.creator, "User is not the creator of the poll.");
    require(polls.status == PollStatus.IN_PROGRESS, "Vote is not in progress.");
    require(now >= getPollExpirationTime(), "Voting period has not expired");
    polls.status = PollStatus.TALLY;
  }

  /*
   * The callback function. Checks if a poll was passed given the quorum percentage and vote distribution.
   * NOTE: Only the Enigma contract can call this function.
   */
  function updatePollStatus(uint _yeaVotes, uint _nayVotes) public onlyEnigma() {
    require(getPollStatus() == PollStatus.TALLY, "Poll has not expired yet.");
    polls.yeaVotes = _yeaVotes;
    polls.nayVotes = _nayVotes;

    bool pollStatus = (polls.yeaVotes.mul(100)) > polls.quorumPercentage.mul(polls.yeaVotes.add(polls.nayVotes));
    if (pollStatus) {
      polls.status = PollStatus.PASSED;
    }
    else {
      polls.status = PollStatus.REJECTED;
    }

    emit pollStatusUpdate(pollStatus);
  }

  /*
   * Gets the status of a poll.
   */
  function getPollStatus() public view returns (PollStatus) {
    return polls.status;
  }

  /*
   * Gets the expiration date of a poll.
   */
  function getPollExpirationTime() public view returns (uint) {
    return polls.expirationTime;
  }

  /*
   * Gets a voter's encrypted vote for a given expired poll.
   */
  function getPollInfoForVoter(address _voter) public view returns (bytes) {
    require(getPollStatus() != PollStatus.IN_PROGRESS);
    require(userHasVoted(_voter));
    return polls.voterInfo[_voter].vote;
  }

  /*
   * Gets all the voters of a poll.
   */
  function getVotersForPoll() public view returns (address[]) {
    require(getPollStatus() != PollStatus.IN_PROGRESS);
    return polls.voters;
  }

  /*
   * Modifier that checks that the contract caller is the Enigma contract.
   */
  modifier onlyEnigma() {
    require(msg.sender == address(enigma));
    _;
  }

  /* VOTE OPERATIONS */

  /*
   * Casts a vote for a given poll.
   */
  function castVote(bytes _encryptedVote) external {
    require(getPollStatus() == PollStatus.IN_PROGRESS, "Poll has expired.");
    require(!userHasVoted(msg.sender), "User has already voted.");
    require(getPollExpirationTime() > now);

    polls.voterInfo[msg.sender] = Voter({
      hasVoted: true,
      vote: _encryptedVote
      });

    polls.voters.push(msg.sender);

    emit voteCasted(msg.sender, _encryptedVote);
  }

  /*
   * The callable function that is computed by the SGX node. Tallies votes.
   */
  function countVotes(uint[] _votes, uint weight) public pure returns (uint, uint) {
    uint yeaVotes;
    uint nayVotes;
    for (uint i = 0; i < _votes.length; i++) {
      if (_votes[i] == 0) nayVotes += weight;
      else if (_votes[i] == 1) yeaVotes += weight;
    }
    return (yeaVotes, nayVotes);
  }

  /*
   * Checks if a user has voted for a specific poll.
   */
  function userHasVoted(address _user) public view returns (bool) {
    return (polls.voterInfo[_user].hasVoted);
  }

}
