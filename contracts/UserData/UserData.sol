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

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "../ContData/ContDataCall.sol";

/**
 * @dev this is an eternal contract which holds all users registered data.
 */
contract UserData is Initializable, ContDataCall {
    function initialize() initializer public {
        __ContDataCall_init();
    }


    /**
     * @dev holding all usernames taken.
     */
    mapping(string => address) usernameToAddr;
    /**
     * @dev emits when a `username` assignes to a `userAddr`.
     */
    event UsernameAssigned(string indexed username, address indexed userAddr);
    /**
     * @dev returns the address who has the `username`.
     */
    function userAddress(string memory username) public view returns(address userAddr){
        userAddr = usernameToAddr[username];
    }
    /**
     * @dev assign the `username` to a `userAddr`. (restricted function)
     */
    function assignUsername(string memory username, address userAddr) 
        external 
        onlyRoll("AccessUserData") 
    {
        usernameToAddr[username] = userAddr;
        emit UsernameAssigned(username, userAddr);
    }



    struct User{
        string username;
        string info;
    }


    /**
     * @dev holding user data.
     */
    mapping(address => User) public addrToUser;
    /**
     * @dev emits when a data sets for a user.
     */
    event SetUsername(address indexed userAddr, string indexed username);
    event SetInfo(address indexed userAddr, string indexed info);
    /**
     * @dev returns the data recorded for a user.
     */
    function addressToUsername(address userAddr) public view returns(string memory username) {
        username = addrToUser[userAddr].username;
    }
    function addressToInfo(address userAddr) public view returns(string memory userInfo) {
        userInfo = addrToUser[userAddr].info;
    }
    /**
     * @dev set the `username` of the `userAddr`. (restricted function)
     */
    function setUsername(address userAddr, string memory username) 
        external 
        onlyRoll("AccessUserData") 
    {
        addrToUser[userAddr].username = username;
    }
    /**
     * @dev set the `info` of the `userAddr`. (restricted function)
     */
    function setInfo(address userAddr, string memory username) 
        external 
        onlyRoll("AccessUserData") 
    {
        addrToUser[userAddr].info = username;
    }
}