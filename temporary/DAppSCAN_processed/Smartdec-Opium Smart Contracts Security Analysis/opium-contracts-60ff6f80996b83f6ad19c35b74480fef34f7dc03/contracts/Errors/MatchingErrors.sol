// File: ../sc_datasets/DAppSCAN/Smartdec-Opium Smart Contracts Security Analysis/opium-contracts-60ff6f80996b83f6ad19c35b74480fef34f7dc03/contracts/Errors/MatchingErrors.sol

pragma solidity ^0.5.4;

contract MatchingErrors {
    string constant internal ERROR_MATCH_CANCELLATION_NOT_ALLOWED = "MATCH:CANCELLATION_NOT_ALLOWED";
    string constant internal ERROR_MATCH_ALREADY_CANCELED = "MATCH:ALREADY_CANCELED";
    string constant internal ERROR_MATCH_ORDER_WAS_CANCELED = "MATCH:ORDER_WAS_CANCELED";

    string constant internal ERROR_MATCH_TAKER_ADDRESS_WRONG = "MATCH:TAKER_ADDRESS_WRONG";
    string constant internal ERROR_MATCH_ORDER_IS_EXPIRED = "MATCH:ORDER_IS_EXPIRED";
    string constant internal ERROR_MATCH_SENDER_ADDRESS_WRONG = "MATCH:SENDER_ADDRESS_WRONG";
    string constant internal ERROR_MATCH_SIGNATURE_NOT_VERIFIED = "MATCH:SIGNATURE_NOT_VERIFIED";
    string constant internal ERROR_MATCH_NOT_ENOUGH_ALLOWED_FEES = "MATCH:NOT_ENOUGH_ALLOWED_FEES";
}
