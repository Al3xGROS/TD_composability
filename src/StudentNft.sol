// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract StudentNft is ERC721 {

	constructor() ERC721("ALEXNFT", "ALNFT") {
		_mint(address(this), 2);
	}

	function mint(uint256 tokenIdToMint) external {

	}

	function burn(uint256 tokenIdToBurn) external {

	}
}
