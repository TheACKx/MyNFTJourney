// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';


contract SimpleMintContract is ERC721, Ownable {

    //Cost of mint
    uint256 public mintPrice = 0.01 ether;
    //Supply of our collection
    uint256 public totalSupply;
    //Max supply of our collection
    uint256 maxSupply;
    //Can people mint?
    bool public isMintEnabled;

    //Track number of mints of each wallet
    mapping(address => uint256) public mintedWallets;


    //Constructor run whn we deploy the contract on blockchain
    //Less variables,changes = less gas fees
    //payable : function is able to process transactions with more than or equal to zero Ether
    constructor() payable ERC721('ACK Simple Mint', 'ACK'){
        maxSupply = 5;
    }

    //onlyOwner : this function is only accessible by owner (contract deployer)
    //external : you cannot call this function in other functions
    function toggleIsMintEnabled() external onlyOwner {
        //undefined booleans = false, so isMintEnabled is false at the start
        isMintEnabled = !isMintEnabled;
    }


    function setMaxSupply(uint256 maxSupply_) external onlyOwner{
        maxSupply = maxSupply_;
    }

    function mint() external payable{
        //require is similar if statements
        require(isMintEnabled, 'Minting not enabled');
        //msg.sender :  address of message caller
        require(mintedWallets[msg.sender]<1, 'You can mint only one nft per wallet');
        require(msg.value == mintPrice, 'wrong value');
        //total supply cannot pass maxsupply
        require(maxSupply>= totalSupply, 'sold out');

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        //_safeMint comes from ERC721 contract , it helps sender safely mint , recieve token
        _safeMint(msg.sender, tokenId);
    }

}
