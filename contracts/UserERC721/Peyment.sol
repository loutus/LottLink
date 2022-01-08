// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// ============================ VERSION_1.1.0 ==============================
//   ██       ██████  ████████ ████████    ██      ██ ███    ██ ██   ██
//   ██      ██    ██    ██       ██       ██      ██ ████   ██ ██  ██
//   ██      ██    ██    ██       ██       ██      ██ ██ ██  ██ █████
//   ██      ██    ██    ██       ██       ██      ██ ██  ██ ██ ██  ██
//   ███████  ██████     ██       ██    ██ ███████ ██ ██   ████ ██   ██    
// ======================================================================
//  ================ Open source smart contract on EVM =================
//   ============== Verify Random Function by ChainLink ===============


import "../ERC721/ERC721UncollectibleUpgradeable.sol";
import "../ContData/ContDataCall.sol";
import "../utils/SafeMath.sol";


abstract contract Peyment is ContDataCall, ERC721UncollectibleUpgradeable {

    using SafeMath for uint256;

    mapping(uint256 => uint256) pendingWithdrawals;

    /**
     * @dev checks the username fee and shares it to some addresses.
     * 
     * register fee will be calculated by the username shortness.
     * 
     * Requirements:
     *
     * - Register fee should be sufficient.
     */
    function _registerPayment(
        string memory username,
        uint256 referral,
        uint256 dapp,
        uint256 DAO
    ) internal {

        uint256 amount = msg.value;

        require(amount >= registerFee(username), "insufficient fee for the username");

        uint256 refBon = amount / 100 * referralPercent();
        uint256 dappBon = amount / 100 * dappPercent();

        deposit(referral, refBon);
        deposit(dapp, dappBon);
        deposit(DAO, amount.sub(refBon + dappBon));
    }



    function registerFee(string memory input) internal view returns(uint256){
        return ContDataGetUint(keccak256("RegisterBaseFee")) / 10 ** (bytes(input).length);
    }

    function dappPercent() internal view returns(uint256) {
        return ContDataGetUint(keccak256("RegisterDappPercent"));
    }

    function referralPercent() internal view returns(uint256) {
        return ContDataGetUint(keccak256("RegisterReferralPercent"));
    }


    /**
     * @dev Deposit the `amount` in wei to the `addr` in pendeingwithdrawals;
     */
    function deposit(uint256 userId, uint256 amount) internal {
        pendingWithdrawals[userId] = pendingWithdrawals[userId].add(amount);
    }

    /**
     * @dev returns balance of the `addr` in wei;
     */
    function balanceInWei(uint256 userId) public view returns(uint256) {
        return pendingWithdrawals[userId];
    }

    /**
     * @dev Withdraw your pending supply.
     */
    function withdraw() public {
        address payable receiver = payable(msg.sender);
        uint256 IdCard = tokenOf(receiver);
        uint amount = balanceInWei(IdCard);
        pendingWithdrawals[IdCard] = 0;
        receiver.transfer(amount);
    }
}