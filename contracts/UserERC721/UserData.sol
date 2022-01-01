// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../utils/StringUtil.sol";

abstract contract UserData {

    using StringUtil for string;

    mapping(string => bool) usernamesTaken;

    function hasTaken(string memory username) public view returns(bool){
        return usernamesTaken[username.lower()];
    }
    /**
     * @dev assign the `username` to a `userAddr`. (restricted function)
     */
    function _takeUsername(string memory username) internal {
        require(!hasTaken(username), "This username has been taken before");
        usernamesTaken[username.lower()] = true;
    }



    struct User {
        string username;
        string infoHash;
    }

    mapping(uint256 => User) users;


    function _setUserData(
        uint256 userId, 
        string memory username, 
        string memory infoHash
    ) internal {
        _takeUsername(username);
        users[userId] = User(username, infoHash);
    } 


    function _burnUserData(uint256 userId) internal {
        delete users[userId];
        delete usernamesTaken[users[userId].username];
    }
}