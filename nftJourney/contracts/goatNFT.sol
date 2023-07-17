// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//we can store metada in blockchain with ERC721URIStorage , a little bit more expensive
contract goatNFT is ERC721URIStorage, Ownable {
    // collection name , symbol
    constructor() ERC721("GOAT of Football", "GOAT"){

    }

    function mint(address _to , uint256 _tokenId , string calldata _uri) external onlyOwner{
        _mint (_to, _tokenId);
        _setTokenURI(_tokenId , _uri);
    }



//deployment hash : https://goerli.etherscan.io/tx/0xa2245a87263df2756792173bf2a42be2b810b077e871a7487e7c481266992b52
//lets put images on ipfs on nft.storage copy ipfs and paste on json and then upload json too. copy json ipfs you will need that for mint
//mint hash : https://goerli.etherscan.io/tx/0x3e7454e6c6002f06ba6ea4da31283f45cbdc1910faa87e182461e1aa6ef9b945
//collection and nft : https://testnets.opensea.io/collection/goat-of-football



}