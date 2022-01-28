// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ERC721Connector.sol";

contract KryptoBird is ERC721Connector {
    // array to store our nfts
    string[] public kryptoBirdz;

    mapping(string => bool) _kryptoBirdzExists;

    function mint(string memory _kryptoBird) public {
        require(
            !_kryptoBirdzExists[_kryptoBird],
            "ERC721: kryptoBird already exists"
        );
        // deprecated => uint _id = kryptoBirdz.push(_kryptoBird);
        // .push no longer returns the length but a ref to the added element
        kryptoBirdz.push(_kryptoBird);
        uint256 _id = kryptoBirdz.length - 1;
        _mint(msg.sender, _id);

        _kryptoBirdzExists[_kryptoBird] = true;
    }

    constructor() ERC721Connector("KryptoBird", "KPBD") {}
}
