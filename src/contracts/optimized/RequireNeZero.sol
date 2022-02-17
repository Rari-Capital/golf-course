// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract RequireNeZero {
    function requireNeZero(uint256 notZero) external pure {
        /// 🚀 Optimized
        require(notZero != 0);
    }

}
