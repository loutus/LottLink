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


import "../ContData/ContDataCall.sol";


abstract contract Peyment is ContDataCall {

    mapping(address => uint256) pendingWithdrawals;

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
        address referral,
        address dapp,
        address DAO
    ) internal {

        uint256 amount = msg.value;

        require(amount >= registerFee(username), "insufficient fee for the username");

        uint256 refBon = amount / 100 * referralPercent();
        uint256 dappBon = amount / 100 * dappPercent();

        deposit(referral, refBon);
        deposit(dapp, dappBon);
        deposit(DAO, amount-(refBon + dappBon));
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
    function deposit(address addr, uint256 amount) internal {
        pendingWithdrawals[addr] += amount;
    }

    /**
     * @dev returns balance of the `addr` in wei;
     */
    function balanceInWei(address addr) public view returns(uint256) {
        return pendingWithdrawals[addr];
    }

    /**
     * @dev Withdraw your pending supply.
     */
    function withdraw() public {
        address payable receiver = payable(msg.sender);
        uint amount = balanceInWei(receiver);
        pendingWithdrawals[receiver] = 0;
        receiver.transfer(amount);
    }
}