// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract UnoptimizedCacheArrLength {
    uint256[] public arr = [uint256(1), 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function cacheArrLength() external view {
        for (uint256 index; index < arr.length; ++index) {}
    }

}
