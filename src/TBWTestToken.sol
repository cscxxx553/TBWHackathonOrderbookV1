// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract TBWTestToken is ERC20, ERC20Burnable, Ownable, ERC20Permit {
    uint8 private _decimals;
    constructor(string memory name, string memory symbol, uint8 decimals_) ERC20(name, symbol) ERC20Permit("TWBTestToken") {
        _decimals = decimals_; 
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}