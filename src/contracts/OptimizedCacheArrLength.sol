// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract OptimizedCacheArrLength {
    uint256[] public arr = [uint256(1), 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function cacheArrLength() external view {
        uint256 arrLength = arr.length;

        /// 🚀 Optimized
        for (uint256 index; index < arrLength; ++index) {}
    }

}
