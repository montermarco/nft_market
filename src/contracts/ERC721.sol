// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/**
    Building the minting function
        1- nft point to an address
        2- keep track of tokens ids
        3- keep track of token owner addresses to tokens ids
        4- keep track of how many tokens an owner address has
        5- create event to emit trransfer log
  */

contract ERC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    // mapping in solidity creates a hash table of key pair values
    // mapping from token id to owner
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to number owned tokens
    mapping(address => uint256) private _tokensOwnedCount;

    /// @notice Count all NFTs assigned to an _owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero

    function balanceOf(address _owner) public view returns (uint256) {
        require(
            _owner != address(0),
            "ERC721: owner query - non existing token ..."
        );
        return _tokensOwnedCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT

    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(
            owner != address(0),
            "ERC721: owner query - non existing token ..."
        );
        return owner;
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        // setting the address of the owner to check the mapping of the address from
        // the owner at the tokenId
        address owner = _tokenOwner[tokenId];
        // return true if the address is not cero
        return owner != address(0);
    }

    // we are overwritting this with ERC721Enumerable _mint function, we use it as virtual
    function _mint(address to, uint256 tokenId) internal virtual {
        // the address is not cero
        require(to != address(0), "ERC721: minting to zero address ...");
        // check when we mint an ID that ID does not already exists
        require(!_exists(tokenId), "ERC721: token already minted ...");

        // set the tokenOwner of the tokenID to the address argument to
        // we are adding a new address with a token id for minting, the person minting is gonna get it
        _tokenOwner[tokenId] = to;
        // keeping track of each address that is minting one
        _tokensOwnedCount[to]++;

        emit Transfer(address(0), to, tokenId);
    }
}
