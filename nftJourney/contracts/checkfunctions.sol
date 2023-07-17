// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.9.2/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.9.2/security/Pausable.sol";
import "@openzeppelin/contracts@4.9.2/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.2/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts@4.9.2/utils/cryptography/draft-EIP712.sol";
import "@openzeppelin/contracts@4.9.2/token/ERC721/extensions/draft-ERC721Votes.sol";
import "@openzeppelin/contracts@4.9.2/utils/Counters.sol";

contract CheckAllFuntcions is ERC721, Pausable, Ownable, ERC721Burnable, EIP712, ERC721Votes {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor()
        ERC721("CheckAllFuntcions", "CACK")
        EIP712("CheckAllFuntcions", "1")
    {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function _afterTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Votes)
    {
        super._afterTokenTransfer(from, to, tokenId, batchSize);
    }


    //Onwer retrieve eth
    function withdraw() public onlyOwner{
        require(address(this).balance>0, 'Balance 0');
        payable(owner()).transfer(address(this).balance);
    }
}
