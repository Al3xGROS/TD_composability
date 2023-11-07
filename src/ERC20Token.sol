// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ERC20Token is ERC20 {
    constructor() ERC20("ALEXTOKEN", "ALT") {
        uint256 decimals = decimals();
        uint256 multiplicator = 10 ** decimals;
        uint valueToMint = 100000 * multiplicator;
        _mint(msg.sender, valueToMint);
    }
}