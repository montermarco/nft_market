// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ERC721.sol";

contract ERC721Enumerble is ERC721 {
    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;
    // mapping of owner to list of all owner token ids
    mapping(address => uint256[]) private _ownedTokens;
    // mapping from tokenId to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokensIndex;

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() external view returns (uint256) {
        return _allTokens.length;
    }

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);
        _addTokensToTotalSupply(tokenId);
    }

    function _addTokensToTotalSupply(uint256 tokenId) private {
        _allTokens.push(tokenId);
    }
}
