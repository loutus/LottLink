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

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @title ERC721 Uncollectible Token
 * @dev ERC721 Token that every address can just have one of it.
 */
abstract contract ERC721UncollectibleUpgradeable is Initializable, ContextUpgradeable, ERC721Upgradeable {
    function __ERC721Uncollectible_init() internal onlyInitializing {
        __Context_init_unchained();
        __ERC165_init_unchained();
        __ERC721Uncollectible_init_unchained();
    }

    function __ERC721Uncollectible_init_unchained() internal onlyInitializing {
    }

    /**
     * @dev Returns true if `addr` has a token.
     */
    function ownsToken(address addr)public view returns(bool){
        return(balanceOf(addr) != 0);
    }


    mapping(address => uint256) addrToTokenId;

    /**
     * @dev Returns the tokenId of the `addr`.
     * 
     * since every owner can just have one token, we can get the tokenId if we have the owner address.
     * 
     * Requirements:
     *
     * - `addr` should own a token.
     */
    function tokenOf(address addr) public view returns(uint256) {
        require(ownsToken(addr), "ERC721UncollectibleUpgradeable: this address does not have a token");
        return addrToTokenId[addr];
    }


    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);

        //check if to address is free
        require(!ownsToken(to), "ERC721UncollectibleUpgradeable: this address does have a token");
    }

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )
        internal
        override
    {
        super._afterTokenTransfer(from, to, tokenId);

        // make from address free and transfer the `tokenId` to `to` address
        delete addrToTokenId[from];
        addrToTokenId[to] = tokenId;
    }
}