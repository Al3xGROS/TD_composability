// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {IStudentToken} from "./IStudentToken.sol";
import {IEvaluator} from "./IEvaluatorToken.sol";
// import {RewardToken} from "./RewardToken.sol";

import {IUniswapV3Factory} from "../node_modules/@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import {IUniswapV3Pool} from "../node_modules/@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import {ISwapRouter} from "../node_modules/@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import {IQuoter} from "../node_modules/@uniswap/v3-periphery/contracts/interfaces/IQuoter.sol";

contract StudentToken is ERC20, IStudentToken {
    IUniswapV3Factory public factory = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984);
    ISwapRouter public router = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    IQuoter public quoter = IQuoter(0xb27308f9F90D607463bb33eA1BeBb41C27CE5AB6);
    address public rewardTokenAddress = 0x56822085cf7C15219f6dC404Ba24749f08f34173;
    IEvaluator public evaluatorToken = IEvaluator(0x5cd93e3B0afBF71C9C84A7574a5023B4998B97BE);

    constructor() ERC20("ALEXTOKEN", "ALT") {
        uint256 decimals = decimals();
        uint256 multiplicator = 10 ** decimals;
        uint valueToMint = 100000000 * multiplicator;
        _mint(address(this), valueToMint);
    }

    function approveAdmin(address spender, uint256 value) public virtual returns (bool) {
        address owner = address(this);
        _approve(owner, spender, value);
        return true;
    }

    function transferAdmin(address to, uint256 value) public virtual returns (bool) {
        _transfer(address(this), to, value);
        return true;
    }

    function createLiquidityPool() external {
        factory.createPool(address(evaluatorToken), rewardTokenAddress, 3000);
    }

	function SwapRewardToken(uint256 amountOut) external{
        address tokenIn = address(evaluatorToken);
        address tokenOut = rewardTokenAddress;

        address poolAddress = factory.getPool(tokenIn, tokenOut, 500);

        IUniswapV3Pool pool = IUniswapV3Pool(poolAddress);
        uint24 fee = pool.fee();

        uint160 sqrtPriceLimitX96 = 0;
        uint256 amountInEstimate = quoter.quoteExactOutputSingle(tokenIn, tokenOut, fee, amountOut, sqrtPriceLimitX96);
        uint256 amountInMaximum = amountInEstimate * 110 / 100;

        ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter.ExactOutputSingleParams({
            tokenIn: tokenIn,
            tokenOut: tokenOut,
            fee: fee,
            recipient: msg.sender,
            deadline: block.timestamp + 120,
            amountOut: amountOut,
            amountInMaximum: amountInMaximum,
            sqrtPriceLimitX96: sqrtPriceLimitX96
        });

        evaluatorToken.approve(address(router), amountInMaximum);

        router.exactOutputSingle(params);
    } 
}