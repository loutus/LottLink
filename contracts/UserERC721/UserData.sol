// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../utils/StringUtil.sol";

abstract contract UserData {


    using StringUtil for string;

    mapping(string => uint256) usernameToUserId;
    /**
     * @dev Returns the userId of the `_username`.
     */
    function userId(string memory _username) public view returns(uint256){
        return usernameToUserId[_username.lower()];
    }
    /**
     * @dev Returns true if the `username` has been registered before.
     */
    function registered(string memory _username) public view returns(bool){
        return userId(_username) != 0;
    }
    /**
     * @dev assign the `username` to an `NFU`.
     */
    function _takeUsername(string memory _username, uint256 _userId) internal {
        require(!registered(_username), "This username has been taken before");
        usernameToUserId[_username.lower()] = _userId;
    }



    struct User {
        string username;
        string infoHash;
        string presenter;
    }

    mapping(uint256 => User) users;

    /**
     * @dev create the profile of the user.
     */
    function _setProfile(
        uint256 _userId, 
        string memory _username, 
        string memory _infoHash,
        string memory _presenter
    ) internal {
        _takeUsername(_username, _userId);
        users[_userId] = User(_username, _infoHash, _presenter);
        emit NewUser(_userId, _username, _infoHash, _presenter);
    }
    /**
     * @dev emit when a new user signs in.
     */
    event NewUser(uint256 _userId, string _username, string _infoHash, string _presenter);
    /**
     * @dev User profile is visible using `_userId` or `_username`.
     */ 
    function username(uint256 _userId) public view returns(string memory) {
        return users[_userId].username;
    }
    function userProfile(uint256 _userId) public view returns(User memory) {
        return users[_userId];
    }
    function userProfile(string memory _username) public view returns(User memory) {
        return users[userId(_username)];
    }
}