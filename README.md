## TD Composability

For this TD, you will be evaluated in two ways:
- first by sending to the teacher your github repository because for all exercises, you must write some solidity code or use `cast` tool but not just call etherscan. Please complete `IStudentToken.sol` and `IStudentNft.sol` also.
- second by calling exercice functions when needing (variable `exerciceProgression` will be check for evaluation)


**Here are specifics details:**

Ex 1: Deploy an ERC20 contract (2pts)

Ex 2: Mint your ERC20 tokens by calling `ex2_mintStudentToken` (2pts)

Ex 3: Mint some EvaluatorTokens by calling `ex3_mintEvaluatorToken` (2 pts)

Ex 4: From your smart contract, you must call uniswap V3 smart contracts in order to swap EvaluatorToken <> RewardToken. Then call `ex4_checkRewardTokenBalance`  (2 pts)

Ex 5: You must send to the Evaluator smart contract some RewardToken by calling `ex5_checkRewardTokenBalance` (2 pts)

Ex 6: Create a liquidity pool on uniswap V3 between your ERC20 tokens and some WETH. You must use Uniswap smart contracts (2 pts)

Ex 7: Deploy an ERC721 (2 pts)

Ex 8: Mint some ERC721's by calling `ex8_mintNFT` (2 pts)

Ex 9: Ouch... my Evaluator contract is admin of your ERC721 token. He has full rights and you must call `ex9_burnNft` (1 pts)

Ex 10: Verify your smart contract on Etherscan and sourcify (1 pts)

Ex 11: Simply call `ex11_unlock_ethers` (2 pts)

BONUS:
- You succeed to make all the TD in one transaction (1 pt)
- You can automate some tasks (like deployment) in a makefile (1 pt)


-----------------------------------------
Deployed Addresses on goerli:
- [Evaluator contract](https://goerli.etherscan.io/address/0x5cd93e3B0afBF71C9C84A7574a5023B4998B97BE)
- [Reward contract](https://goerli.etherscan.io/address/0x56822085cf7C15219f6dC404Ba24749f08f34173)


-----------------------------------------

**Here are the foundry commands for each ex:**


*EX 1 :*
- forge script script/Deployment.sol:DeploymentScript --rpc-url $GOERLIINFURARPC --broadcast -vvvv

*EX2 :*
- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "registerStudentToken(address)" $STUDENTERC20ADDRESS

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $STUDENTERC20ADDRESS "approveAdmin(address, uint256)" $EVALUATORTOKENADDRESS 10000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "ex2_mintStudentToken()"

*EX 3 :*
- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $STUDENTERC20ADDRESS "approveAdmin(address, uint256)" $EVALUATORTOKENADDRESS 30000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $STUDENTERC20ADDRESS "transferAdmin(address, uint256)" $EVALUATORTOKENADDRESS 20000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "ex3_mintEvaluatorToken()"

*EX 4 :*
- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "approve(address, uint256)" $STUDENTERC20ADDRESS 8000000000000000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "transfer(address, uint256)" $STUDENTERC20ADDRESS 8000000000000000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $STUDENTERC20ADDRESS "SwapRewardToken(uint256)" 5000000000000000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "ex4_checkRewardTokenBalance()"

*EX 5 :*
- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "approve(address, uint256)" $STUDENTERC20ADDRESS 14000000000000000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "transfer(address, uint256)" $STUDENTERC20ADDRESS 14000000000000000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $STUDENTERC20ADDRESS "SwapRewardToken(uint256)" 10000000000000000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $REWARDTOKENADDRESS "approve(address, uint256)" $EVALUATORTOKENADDRESS 10000000000000000000

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "ex5_checkRewardTokenBalance()"

*EX 6 :*
- DiDn'T dO sOrRy

*EX 7 :*
- forge script script/Deployment.sol:DeploymentScript --rpc-url $GOERLIINFURARPC --broadcast -vvvv

*EX 8 :*
- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "registerStudentNft(address)" $STUDENTERC721ADDRESS

- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "ex8_mintNFT()"

*EX 9 :*
- cast send --private-key $PRIVATEKEY --rpc-url $GOERLIINFURARPC $EVALUATORTOKENADDRESS "ex9_burnNft()"

*EX 10 :*
- DiDn'T dO sOrRy

*EX 11 :*
- DiDn'T dO sOrRy
