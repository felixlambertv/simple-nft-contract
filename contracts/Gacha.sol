// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./INFT.sol";

contract Gacha is Ownable {
    address public nftAddress;
    mapping(address => string[]) public userToOwnedGacha;
    uint8 limitNft;

    constructor(address _nftAddress, uint8 _limitNft){
        nftAddress = _nftAddress;
        limitNft = _limitNft;
    }

    modifier limitGacha(){
        require(
            IERC721(nftAddress).balanceOf(msg.sender) < limitNft, "Maximal gacha 2 times"
        );
        _;
    }

    function setLimitNft(uint8 _limitNft) public onlyOwner {
        limitNft = _limitNft;
    }

    function random() private returns (string memory) {
        string[3] memory rarityList = INFT(nftAddress).getRarityList();
        uint randomValue = uint(keccak256(abi.encodePacked(block.timestamp))) % (2);
        return rarityList[randomValue];
    }

    function getUserNftList(address addr) public view returns(string[] memory) {
        return userToOwnedGacha[addr];
    }

    function gacha() public limitGacha {
        INFT(nftAddress).safeMint(msg.sender);
        userToOwnedGacha[msg.sender].push(random());
    }
}