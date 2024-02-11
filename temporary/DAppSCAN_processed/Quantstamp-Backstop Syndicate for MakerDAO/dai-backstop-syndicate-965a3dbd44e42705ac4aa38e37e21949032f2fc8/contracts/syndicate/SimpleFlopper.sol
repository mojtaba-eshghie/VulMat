// File: ../sc_datasets/DAppSCAN/Quantstamp-Backstop Syndicate for MakerDAO/dai-backstop-syndicate-965a3dbd44e42705ac4aa38e37e21949032f2fc8/contracts/interfaces/IFlopper.sol

pragma solidity 0.5.16;

interface IFlopper {
    // --- Auth ---
    // caller authorization (1 = authorized, 0 = not authorized)
    function wards(address) external view returns (uint256);
    // authorize caller
    function rely(address usr) external;
    // deauthorize caller
    function deny(address usr) external;

    // Bid objects
    function bids(uint256) external view returns (
        uint256 bid,
        uint256 lot,
        address guy,
        uint48 tic,
        uint48 end
    );

    // DAI contract address
    function vat() external view returns (address);
    // MKR contract address
    function gem() external view returns (address);

    // num decimals (constant)
    function ONE() external pure returns (uint256);

    // minimum bid increase (config - 5% initial)
    function beg() external view returns (uint256);
    // initial lot increase (config - 50% initial)
    function pad() external view returns (uint256);
    // bid lifetime (config - 3 hours initial)
    function ttl() external view returns (uint48);
    // total auction length (config - 2 days initial)
    function tau() external view returns (uint48);

    // number of auctions
    function kicks() external view returns (uint256);
    // status of the auction (1 = active, 0 = disabled)
    function live() external view returns (uint256);
    // user who shut down flopper mechanism and paid off last bid
    function vow() external view returns (address);

    // --- Events ---
    event Kick(uint256 id, uint256 lot, uint256 bid, address indexed gal);

    // --- Admin ---
    function file(bytes32 what, uint256 data) external;

    // --- Auction ---

    // create an auction 
    // access control: authed
    // state machine: after auction expired
    // gal - recipient of the dai
    // lot - amount of mkr to mint
    // bid - amount of dai to pay
    // id - id of the auction
    function kick(address gal, uint256 lot, uint256 bid) external returns (uint256 id);

    // extend the auction and increase minimum maker amount minted
    // access control: not-authed
    // state machine: after auction expiry, before first bid
    // id - id of the auction
    function tick(uint256 id) external;

    // bid up auction and refund locked up dai to previous bidder
    // access control: not-authed
    // state machine: before auction expired
    // id - id of the auction
    // lot - amount of mkr to mint
    // bid - amount of dai to pay
    function dent(uint256 id, uint256 lot, uint256 bid) external;

    // finalize auction
    // access control: not-authed
    // state machine: after auction expired
    // id - id of the auction
    function deal(uint256 id) external;

    // --- Shutdown ---

    // shutdown flopper mechanism
    // access control: authed
    // state machine: anytime
    function cage() external;

    // get cancelled bid back
    // access control: authed
    // state machine: after shutdown
    function yank(uint256 id) external;
}

// File: ../sc_datasets/DAppSCAN/Quantstamp-Backstop Syndicate for MakerDAO/dai-backstop-syndicate-965a3dbd44e42705ac4aa38e37e21949032f2fc8/contracts/syndicate/SimpleFlopper.sol

pragma solidity 0.5.16;

contract SimpleFlopper {

  // A "flopper" is a contract for auctioning off MKR in exchange for Dai.
  IFlopper private _auction;

  constructor(address auction) public {
    _auction = IFlopper(auction);
  }

  // Getters //

  /// @notice Get the status of the flopper contract
  /// @return bool status true if auction contract is enabled
  function isEnabled() public view returns (bool status) {
    return (_auction.live() == 1) ? true : false;
  }

  /// @notice Get the id of the latest auction
  /// @return auctionID uint256 id
  function getTotalNumberOfAuctions() public view returns (uint256 auctionID) {
    return _auction.kicks();
  }

  /// @notice Get the address of the auction contract (Flopper)
  /// @return Auction address
  function getFlopperAddress() public view returns (address flopper) {
    return address(_auction);
  }

  /// @notice Get the flopper contract config
  /// @return bidIncrement uint256 minimum bid increment as percentage (initial = 1.05E18)
  /// @return repriceIncrement uint256 reprice increment as percentage (initial = 1.50E18)
  /// @return bidDuration uint256 duration of a bid in seconds (initial = 3 hours)
  /// @return auctionDuration uint256 initial duration of an auction in seconds (initial = 2 days)
  function getAuctionInformation() public view returns (
    uint256 bidIncrement,
    uint256 repriceIncrement,
    uint256 bidDuration,
    uint256 auctionDuration
  ) {
    return (_auction.beg(), _auction.pad(), _auction.ttl(), _auction.tau());
  }

  /// @notice Get the winning bid for an auction
  /// @return amountDAI uint256 amount of DAI to be burned
  /// @return amountMKR uint256 amount of MKR to be minted
  /// @return bidder address account who placed bid
  /// @return bidDeadline uint48 deadline of bid
  /// @return auctionDeadline uint48 deadline of auction
  function getCurrentBid(uint256 auctionID) public view returns (
    uint256 amountDAI,
    uint256 amountMKR,
    address bidder,
    uint48 bidDeadline,
    uint48 auctionDeadline
  ) {
    return _auction.bids(auctionID);
  }

  // Setters //

  /// @notice Extend and reprice expired auction with no bid
  /// @dev state machine: after auction expiry, before first bid
  /// @param auctionID uint256 id of the auction
  function _reprice(uint256 auctionID) internal {
    _auction.tick(auctionID);
  }

  /// @notice Add bid to a live auction, if first bid this transfers DAI to vat
  /// @dev state machine: before auction expired
  /// @param auctionID uint256 id of the auction
  function _bid(uint256 auctionID, uint256 amountMKR, uint256 amountDAI) internal {
    _auction.dent(auctionID, amountMKR, amountDAI);
  }

  /// @notice Finalize an auction with a winning bid and release maker
  /// @dev state machine: after auction expired
  /// @param auctionID uint256 id of the auction
  function _finalize(uint256 auctionID) internal {
    _auction.deal(auctionID);
  }

}
