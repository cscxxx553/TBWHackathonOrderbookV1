// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.19;

import "./AMM.sol";
// import {ERC20} from "openzeppelin/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";

contract TJSwap is Ownable {
    AMM _theAmm = AMM(0x1d9Bf45036e0078F1058dca9935f1f3cB6D141B6);
    // uint16 internal constant DEFAULT_BIN_STEP = 10;
    uint256 public token0Price;
    uint256 public token1Price;
    uint256 public tokenRatio;

    constructor(uint256 _token0Price, uint256 _token1Price){
        token0Price = _token0Price;
        token1Price = _token1Price;
        tokenRatio = (token0Price*100) / token1Price;
    }
    function swapExactTForTV1() external onlyOwner {
        IERC20 token0 = IERC20(0xafb5188894da64AcFF12Ec6cb93bCBB45F555910);
        IERC20 token1 = IERC20(0x76097e10C5095aF7279c2eA53A3Cf6801D10e807);
        // require((IERC20(token0).balanceOf(address(this))) < 1000000000000000000, "Insufficient balance of token1.");
        // require((IERC20(token1).balanceOf(address(this))) < 400000000000000000000, "Insufficient balance of token2.");
        // require(sellAmountPerTime > 10000000000000000, "The Sell Amount Per Time should be greater than 0.01 .");
        // require(sellAmountPerTime < 1000000000000000000000, "The Sell Amount Per Time should be less than 1000 .");
        // require(priceCeiling > 0, "The Price Ceiling should be greater than 0 .");
        // require(priceCeiling > priceFloor, "The Price Ceiling should be greater than Price Floor .");
        // require((priceCeiling - priceFloor) > 10, "The Price Ceiling should be greater than Price Floor .");
        // require(currentPriceOfSwapPair > 0, "The current price of swap pair can not be 0 .");
        // require(pointPrice > 0, "The point price can not be 0 .");
        
        uint256 newPriceRatio = (token0Price*100)/token1Price;
        if(newPriceRatio > tokenRatio && ((((newPriceRatio-tokenRatio)*100)/tokenRatio)>3)){
            token0.approve(address(_theAmm), 100000000000000000000);
            _theAmm.swap(address(token0), 1000000000000000000);
            tokenRatio = (token0Price*100)/token1Price;
        }else if(tokenRatio > newPriceRatio && ((((tokenRatio-newPriceRatio)*100)/newPriceRatio)>3)){
            token1.approve(address(_theAmm), 40000000000000000000000);
            _theAmm.swap(address(token1), 400000000000000000000);
            tokenRatio = (token0Price*100)/token1Price;
        }

    }

    function setToken0Price(uint256 newToken0Price) external {
        token0Price = newToken0Price;
    }

    function setToken1Price(uint256 newToken1Price) external {
        token1Price = newToken1Price;
    }

    function getNewPriceRatio() external view returns(uint256){
        return (token0Price*100)/token1Price;
    }

    receive() external payable {}
}

