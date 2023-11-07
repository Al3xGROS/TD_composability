// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {IStudentNft} from "./IStudentNft.sol";
import {IEvaluator} from "./IEvaluatorToken.sol";

contract StudentNft is ERC721, IStudentNft {
	IEvaluator public evaluatorToken = IEvaluator(0x5cd93e3B0afBF71C9C84A7574a5023B4998B97BE);

	constructor() ERC721("ALEXNFT", "ALNFT") {
		_mint(address(this), 2);
	}

	function mint(uint256 tokenIdToMint) external {
		// Check the number of token the contract is allowed to spend
		// Should be 0 the first time it's called
		// Then after _approve function is called, allowance should go to 10
		uint256 approvedAmount = evaluatorToken.allowance(msg.sender, address(this));
        require(approvedAmount > 0, "cannot mint nft without collateral");

		// Transfer the approved amount to this contract
        evaluatorToken.transferFrom(msg.sender, address(this), approvedAmount);
        _mint(msg.sender, tokenIdToMint);
	}

	function burn(uint256 tokenIdToBurn) external {
		_burn(tokenIdToBurn);
	}
}
