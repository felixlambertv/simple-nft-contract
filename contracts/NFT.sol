// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./INFT.sol";

contract NFT is ERC721, ERC721URIStorage, INFT {
    using Counters for Counters.Counter;

    string public baseUri;
    string[3] private rarityNameList;
    mapping(string => uint8) private rarityNameToRate;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("IAV", "IAV") {
        baseUri = "https://cloudflare-ipfs.com/ipfs/";
        rarityNameList[0] = "Good";
        rarityNameList[1] = "Normal";
        rarityNameList[2] = "Bad";

        rarityNameToRate["Good"] = 10;
        rarityNameToRate["Normal"] = 60;
        rarityNameToRate["Bad"] = 30;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseUri;
    }

    function safeMint(address to) public override {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    function setTokenUri(uint256 _tokenId, string memory _newTokenUri) public override  {
        require(msg.sender == this.ownerOf(_tokenId), "Invalid owner");
        _setTokenURI(_tokenId, _newTokenUri);
    }

    function getRarityList() public view override returns(string[3] memory) {
        return rarityNameList;
    }

    function getRarityRate(string memory _name) external view override returns(uint8 rate){
        return rarityNameToRate[_name];
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}