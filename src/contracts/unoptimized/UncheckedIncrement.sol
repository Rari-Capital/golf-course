// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract UncheckedIncrement {
    uint256[] public arr = [uint256(1), 2, 3, 4, 5, 6, 7, 8, 9, 10];

    function uncheckedIncrement() external view {
        uint256 arrLength = arr.length;

        /// 🤦 Unoptimized
        for (uint256 index; index < arrLength; ++index) {}
    }

}
