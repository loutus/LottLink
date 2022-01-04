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
import "./IdCard.sol";
import "./UserData.sol";
import "./Peyment.sol";

contract Register is IdCard, UserData, Peyment {
    using CountersUpgradeable for CountersUpgradeable.Counter;
    CountersUpgradeable.Counter private _userIdCounter;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() initializer {}
    function initialize() initializer public {
        __ERC721_init("IdCard", "IDC");
        __ERC721URIStorage_init();
        __Pausable_init();
        __Ownable_init();
        __ERC721Burnable_init();
        _safeMint(owner(), 0); // number `0` token mints to the DAO
    }




    /**
     * @dev Sign in the Register contract by adopting a `username` and optional info.
     * 
     * Requirements:
     *
     * - Every address can only sign one username.
     * - Not allowed empty usernames.
     * - User has to adopt a username not taken before.
     * - SignIn is payable and corresponds to the username length.
     * 
     * "polygon" suffix will be appended to the end of username automatically.
     */
    function signIn(
        string memory username, 
        string memory infoHash, 
        string memory referral,
        uint256 dappId,
        string memory uri
    ) external payable {
        _registerPayment(
            username, 
            ownerOf(userId(referral)), 
            ownerOf(dappId), 
            owner()
        );

        _userIdCounter.increment();
        uint256 userId = _userIdCounter.current();
        _safeMint(msg.sender, userId);

        _setTokenURI(userId, uri);

        _setProfile(userId, username, infoHash, referral, dappId);
    }


    function version() public pure returns(string memory V_) {
        V_ = "1.1.0";
    }
}