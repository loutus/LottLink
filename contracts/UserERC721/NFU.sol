// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";

contract NFU is Initializable, ERC721Upgradeable, ERC721URIStorageUpgradeable, PausableUpgradeable, OwnableUpgradeable, ERC721BurnableUpgradeable {

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId);
        require(!registered(to), "the user has signed in before");
    }

    // The following functions are overrides required by Solidity.
    
    mapping(address => uint256) addrToUserId;

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )
        internal
        override
    {
        super._afterTokenTransfer(from, to, tokenId);
        addrToUserId[to] = addrToUserId[from];
        delete addrToUserId[from];
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }





    function registered(address userAddr)public view returns(bool){
        return(balanceOf(userAddr) != 0);
    }



    uint256 _baseFee = 10000 * 10 ** 18;
    function calculateFee(string memory input) internal view returns(uint256){
        return _baseFee / 10 ** (bytes(input).length);
    }
}