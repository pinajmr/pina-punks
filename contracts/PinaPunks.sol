// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";
import "./Base64.sol";

contract PinaPunks is ERC721, ERC721Enumerable, PaymentSplitter {
    
    using Counters for Counters.Counter;


    Counters.Counter private _idCounter;
    uint256 public maxSupply;
    
    
    
    constructor(address[] memory _payees, uint256[] memory  _shares, uint256 _maxSupply) ERC721("PinaPunks", "PP") PaymentSplitter(_payees, _shares) payable {
        maxSupply = _maxSupply;
    }
    

    function mint() public payable {
        require(msg.value >= 50000000000000000,"you neet 0.05 ETH to mint the PinaPunks");
        uint256 current = _idCounter.current();
        require(current < maxSupply, "No PinaPunks left:(" );
        _safeMint(msg.sender, current);
        _idCounter.increment(); 

    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "ERC721 Metadata: URI query for nonexistent token");
        
        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "PinaPunks #',
                tokenId,
                '"external_url": "ipfs://<hash>"',
                '", "description": "PinaPunks  customized Avataaars stored on chain to teach DApp development on PinaDev", "image": "',
                "// TODO: Calculate image URL",
                '"}'
            )
        );

        return string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }

    //Override required
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}