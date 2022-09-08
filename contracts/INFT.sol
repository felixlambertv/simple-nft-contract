// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface INFT {
    function safeMint(address _to) external;
    function getRarityList() external returns(string[3] memory);
    function setTokenUri(uint256 _tokenId, string memory _newTokenUri) external;
}