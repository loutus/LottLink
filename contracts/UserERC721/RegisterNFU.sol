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

import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./NFU.sol";
import "./UserData.sol";

contract RegisterNFU is NFU, UserData {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter private _userIdCounter;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}
    function initialize() initializer public {
        __ERC721_init("NonFungibleUser", "NFU");
        __ERC721URIStorage_init();
        __Pausable_init();
        __Ownable_init();
        __ERC721Burnable_init();
    }




    mapping(address => bool) presented;
    function present(address addr) public ownerOrUser {
        presented[addr] = true;
    }

    /**
     * @dev Sign in the Register contract by adopting a `username` and optional info.
     * 
     * Requirements:
     *
     * - Every address can only sign one username.
     * - Not allowed empty usernames.
     * - User has to adopt a username not taken before.
     */
    function signIn(string memory username, string memory infoHash, string memory uri) external payable {
        require(presented[msg.sender], "you should be presented by the DAO or a user");
        require(bytes(username).length >= 3, "lesser than 3 literals");

        uint256 userId = _userIdCounter.current();
        _userIdCounter.increment();
        _safeMint(msg.sender, userId);

        _setTokenURI(userId, uri);

        _setUserData(userId, username, infoHash);
    }

}