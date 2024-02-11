// File: ../sc_datasets/DAppSCAN/SlowMist-ForTube2.0 Smart Contract Security Audit Report/bond-854527d0ea7ad2ddd3504b4d4ae3fcb57cb6445d/contracts/Rating.sol

pragma solidity >=0.6.0;


contract Rating {
    string public name;
    uint256 public risk;
    bool public fine;

    constructor(string memory _name, uint256 _risk, bool _fine) public {
        name = _name;
        risk = _risk;
        fine = _fine;
    }
}
