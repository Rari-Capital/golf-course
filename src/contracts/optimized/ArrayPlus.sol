// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract ArrayPlus {
    uint256[2] public arr = [uint256(1), 2];

    function arrayPlus() external {
        /// 🚀 Optimized
        arr[0] = arr[0] + 4;
    }

}
