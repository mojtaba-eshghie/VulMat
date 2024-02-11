// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Amp/flexa-collateral-manager-4203e96d1138632a991d072d0c232fd8ba69c9e1/contracts/amp/IAmp.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;


interface IAmp {
    function registerCollateralManager() external;
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Amp/flexa-collateral-manager-4203e96d1138632a991d072d0c232fd8ba69c9e1/contracts/amp/IAmpTokensRecipient.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;


/**
 * @title IAmpTokensRecipient
 * @dev IAmpTokensRecipient token transfer hook interface
 */
interface IAmpTokensRecipient {
    /**
     * @dev Report if the recipient will successfully receive the tokens
     */
    function canReceive(
        bytes4 functionSig,
        bytes32 partition,
        address operator,
        address from,
        address to,
        uint256 value,
        bytes calldata data,
        bytes calldata operatorData
    ) external view returns (bool);

    /**
     * @dev Hook executed upon a transfer to the recipient
     */
    function tokensReceived(
        bytes4 functionSig,
        bytes32 partition,
        address operator,
        address from,
        address to,
        uint256 value,
        bytes calldata data,
        bytes calldata operatorData
    ) external;
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Amp/flexa-collateral-manager-4203e96d1138632a991d072d0c232fd8ba69c9e1/contracts/amp/IAmpTokensSender.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;


/**
 * @title IAmpTokensSender
 * @dev IAmpTokensSender token transfer hook interface
 */
interface IAmpTokensSender {
    /**
     * @dev Report if the transfer will succeed from the pespective of the
     * token sender
     */
    function canTransfer(
        bytes4 functionSig,
        bytes32 partition,
        address operator,
        address from,
        address to,
        uint256 value,
        bytes calldata data,
        bytes calldata operatorData
    ) external view returns (bool);

    /**
     * @dev Hook executed upon a transfer on behalf of the sender
     */
    function tokensToTransfer(
        bytes4 functionSig,
        bytes32 partition,
        address operator,
        address from,
        address to,
        uint256 value,
        bytes calldata data,
        bytes calldata operatorData
    ) external;
}

// File: ../sc_datasets/DAppSCAN/ConsenSys Diligence-Amp/flexa-collateral-manager-4203e96d1138632a991d072d0c232fd8ba69c9e1/contracts/amp/MockAmp.sol

// SPDX-License-Identifier: MIT

pragma solidity 0.6.9;



contract MockAmp is IAmp, IAmpTokensRecipient, IAmpTokensSender {
    function registerCollateralManager() external override {}

    function canReceive(
        bytes4 functionSig,
        bytes32 partition,
        address operator,
        address from,
        address to,
        uint256 value,
        bytes calldata data,
        bytes calldata operatorData
    ) external override view returns (bool) {
        IAmpTokensRecipient recipient = IAmpTokensRecipient(to);

        return
            recipient.canReceive(
                functionSig,
                partition,
                operator,
                from,
                to,
                value,
                data,
                operatorData
            );
    }

    function tokensReceived(
        bytes4 functionSig,
        bytes32 partition,
        address operator,
        address from,
        address to,
        uint256 value,
        bytes calldata data,
        bytes calldata operatorData
    ) external override {
        IAmpTokensRecipient recipient = IAmpTokensRecipient(to);

        return
            recipient.tokensReceived(
                functionSig,
                partition,
                operator,
                from,
                to,
                value,
                data,
                operatorData
            );
    }

    function canTransfer(
        bytes4 functionSig,
        bytes32 partition,
        address operator,
        address from,
        address to,
        uint256 value,
        bytes calldata data,
        bytes calldata operatorData
    ) external override view returns (bool) {
        IAmpTokensSender sender = IAmpTokensSender(from);

        return
            sender.canTransfer(
                functionSig,
                partition,
                operator,
                from,
                to,
                value,
                data,
                operatorData
            );
    }

    function tokensToTransfer(
        bytes4 functionSig,
        bytes32 partition,
        address operator,
        address from,
        address to,
        uint256 value,
        bytes calldata data,
        bytes calldata operatorData
    ) external override {
        IAmpTokensSender sender = IAmpTokensSender(from);

        return
            sender.tokensToTransfer(
                functionSig,
                partition,
                operator,
                from,
                to,
                value,
                data,
                operatorData
            );
    }
}
