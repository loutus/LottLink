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


import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./IContData.sol";

/**
 * @dev this contract is source of every types of variables used by LOTT.LINK Ecosystem.
 */
contract ContData is IContData, OwnableUpgradeable{

    /**
     * @dev holding one-to-one assignments.
     */
    mapping(bytes32 => bool) bytes32ToBool;
    mapping(bytes32 => uint) bytes32ToUint;
    mapping(bytes32 => int) bytes32ToInt;
    mapping(bytes32 => address) bytes32ToAddress;
    mapping(bytes32 => string) bytes32ToString;
    mapping(bytes32 => bytes) bytes32ToBytes;


    /**
     * @dev emits when a one-to-one variable is assigned or removed.
     */
    event SetBool(bytes32 tag, bool data);
    event SetUint(bytes32 tag, uint data);
    event SetInt(bytes32 tag, int data);
    event SetAddress(bytes32 tag, address data);
    event SetString(bytes32 tag, string data);
    event SetBytes(bytes32 tag, bytes data);


    /**
     * @dev returns any `data` assigned to a `tag`.
     */
    function getBool(bytes32 tag) external view returns(bool data) {
        return bytes32ToBool[tag];
    }
    function getUint(bytes32 tag) external view returns(uint data) {
        return bytes32ToUint[tag];
    }
    function getInt(bytes32 tag) external view returns(int data) {
        return bytes32ToInt[tag];
    }
    function getAddress(bytes32 tag) external view returns(address data) {
        return bytes32ToAddress[tag];
    }
    function getString(bytes32 tag) external view returns(string memory data) {
        return bytes32ToString[tag];
    }
    function getBytes(bytes32 tag) external view returns(bytes memory data) {
        return bytes32ToBytes[tag];
    }


    /**
     * @dev assign `data` to a `tag` decided by the governance.
     */
    function setBool(bytes32 tag, bool data) external onlyOwner {
        bytes32ToBool[tag] = data;
        emit SetBool(tag, data);
    }
    function setUint(bytes32 tag, uint data) external onlyOwner {
        bytes32ToUint[tag] = data;
        emit SetUint(tag, data);
    }
    function setInt(bytes32 tag, int data) external onlyOwner {
        bytes32ToInt[tag] = data;
        emit SetInt(tag, data);
    }
    function setAddress(bytes32 tag, address data) external onlyOwner {
        bytes32ToAddress[tag] = data;
        emit SetAddress(tag, data);
    }
    function setString(bytes32 tag, string memory data) external onlyOwner {
        bytes32ToString[tag] = data;
        emit SetString(tag, data);
    }
    function setBytes(bytes32 tag, bytes memory data) external onlyOwner {
        bytes32ToBytes[tag] = data;
        emit SetBytes(tag, data);
    }
}