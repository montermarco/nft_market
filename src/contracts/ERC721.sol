// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";

/**
    Building the minting function
        1- nft point to an address
        2- keep track of tokens ids
        3- keep track of token owner addresses to tokens ids
        4- keep track of how many tokens an owner address has
        5- create event to emit trransfer log
  */

contract ERC721 is ERC165, IERC721 {
    // mapping in solidity creates a hash table of key pair values
    // mapping from token id to owner
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to number owned tokens
    mapping(address => uint256) private _tokensOwnedCount;

    // mapping from tokenId to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

    constructor() {
        _registerInterface(
            bytes4(
                keccak256("balanceOf(bytes4)") ^
                    keccak256("ownerOf(bytes4)") ^
                    keccak256("transferFrom(bytes4)")
            )
        );
    }

    /// @notice Count all NFTs assigned to an _owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero

    function balanceOf(address _owner) public view override returns (uint256) {
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

    function ownerOf(uint256 _tokenId) public view override returns (address) {
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

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    function _transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        require(_to != address(0), "ERC721: transfer to zero address ...");
        require(
            ownerOf(_tokenId) == _from,
            "ERC721: Transfer invalid, not token owner  ..."
        );

        _tokensOwnedCount[_from]--;
        _tokensOwnedCount[_to]++;
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public override {
        _transferFrom(_from, _to, _tokenId);
    }

    // function approve(address _to, uint256 _tokenId) public {
    //     address owner = ownerOf(_tokenId);
    //     require(_to != owner, "ERC721: Invalid approval to current owner");
    //     require(
    //         msg.sender == owner,
    //         "ERC721: Invalida, current caller is not the owner"
    //     );
    //     _tokenApprovals[_tokenId] = _to;

    //     emit Approve(owner, _to, _tokenId);
    // }

    // need to finish this!!!!!!
    // function isApproveOrOwner(address spender, uint256 _tokenId)
    //     internal
    //     view
    //     returns (bool)
    // {
    //     require(_exists(_tokenId), "ERC721:ERROR Token does not exist");
    //     address owner = ownerOf(_tokenId);
    //     return (spender == owner);
    // }
}
