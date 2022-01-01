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


interface IContData {
    function getBool(bytes32 tag) external view returns(bool data);
    function getUint(bytes32 tag) external view returns(uint data);
    function getInt(bytes32 tag) external view returns(int data);
    function getAddress(bytes32 tag) external view returns(address data);
    function getString(bytes32 tag) external view returns(string memory data);
    function getBytes(bytes32 tag) external view returns(bytes memory data);
}