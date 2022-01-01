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

import "./UserData.sol";
import "../utils/StringUtil.sol";

contract Register {

    using StringUtil for string;

    /**
     * @dev UserData eternal address on MATIC MUMBAI testnet.
     */
    UserData immutable UD = UserData(0xC7543fb7E7FD47672C2D7a0C23C8F63a07f218b1);

    /**
     * @dev returns true if the user has been registered. (by `username`)
     */
    function registered(string memory username) public view returns(bool) {
        return UD.userAddress(username.lower()) != address(0);
    }

    /**
     * @dev returns true if the user has been registered. (by user `address`)
     */
    function registered(address userAddr) public view returns(bool) {
        return bytes(UD.addressToUsername(userAddr)).length > 0;
    }
}