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
import "../ContData/ContDataCall.sol";

contract Register is IdCard, UserData, ContDataCall {
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
    function signIn(
        string memory username, 
        string memory infoHash, 
        string memory presenter,
        string memory uri
    ) external payable {
        require(bytes(username).length > 0, "empty username");
        require(msg.value >= calculateFee(username));

        _userIdCounter.increment();
        uint256 userId = _userIdCounter.current();
        _safeMint(msg.sender, userId);

        _setTokenURI(userId, uri);

        _setProfile(userId, username, infoHash, presenter);
    }


    function calculateFee(string memory input) internal view returns(uint256){
        return ContDataGetUint(keccak256("RegisterBaseFee")) / 10 ** (bytes(input).length);
    }

    function version() public pure returns(string memory V_) {
        V_ = "1.1.0";
    }
}