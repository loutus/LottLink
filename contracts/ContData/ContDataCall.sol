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
import "./IContData.sol";

/**
 * @dev this is an abstract contract which provides functions to call ContData contract.
 */
abstract contract ContDataCall is Initializable {

    IContData ContData;

    /**
     * @dev ContData eternal address on MATIC MUMBAI testnet.
     */
    function __ContDataCall_init() internal onlyInitializing {
        ContData = IContData(0xA4af290CA6eA32e6e909F8cbb4F4dc14ce32b778);
    }

    /**
     * @dev returns any `data` assigned to a `tag`.
     */
    function ContDataGetBool(bytes32 tag) public view returns(bool data) {
        data = ContData.getBool(tag);
    }
    function ContDataGetUint(bytes32 tag) public view returns(uint data) {
        data = ContData.getUint(tag);
    }
    function ContDataGetInt(bytes32 tag) public view returns(int data) {
        data = ContData.getInt(tag);
    }
    function ContDataGetAddress(bytes32 tag) public view returns(address data) {
        data = ContData.getAddress(tag);
    }
    function ContDataGetString(bytes32 tag) public view returns(string memory data) {
        data = ContData.getString(tag);
    }
    function ContDataGetBytes(bytes32 tag) public view returns(bytes memory data) {
        data = ContData.getBytes(tag);
    }


    /**
     * @dev Throws if called by any address except specific roll.
     */
    modifier onlyRoll(string memory roll) {
        require(
            ContDataGetBool(keccak256(abi.encodePacked(roll, msg.sender))), 
            "restricted access to specific roll"
        );
        _;
    }
}