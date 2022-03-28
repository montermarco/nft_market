// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/* is ERC721 */
interface IERC721Metadata {
    /// @notice A descriptive name for a collection of NFTs in this contract
    function name() external view returns (string memory _name);

    /// @notice An abbreviated name for NFTs in this contract
    function symbol() external view returns (string memory _symbol);

    /// function tokenURI(uint256 _tokenId) external view returns (string);
}
