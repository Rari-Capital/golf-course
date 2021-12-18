// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

contract GolfCourse {
    function unoptimizedDivideByTwo() external pure returns (uint256 two) {
        /// 🤦 Unoptimized
        two = 4 / 2;
    }

    function optimizedDivideByTwo() external pure returns (uint256 two) {
        /// 🚀 Optimized
        two = 4 >> 1;
    }

    function unoptimizedPreferGteLteOverGtLt()
        external
        pure
        returns (bool positive)
    {
        /// 🤦 Unoptimized
        positive = 1 > 0;
    }

    function optimizedPreferGteLteOverGtLt()
        external
        pure
        returns (bool positive)
    {
        /// 🚀 Optimized
        positive = 1 >= 1;
    }

    function unoptimizedUseCodeLength() external view returns (uint256) {
        /// 🤦 Unoptimized
        address address_ = address(this);
        uint256 size;
        assembly {
            size := extcodesize(address_)
        }
        return size;
    }

    function optimizedUseCodeLength() external view returns (uint256) {
        /// 🚀 Optimized
        return address(this).code.length;
    }

    function unoptimizedPreferNotEqualOverGtLt()
        external
        pure
        returns (bool notThirtyTwo)
    {
        /// 🤦 Unoptimized
        notThirtyTwo = 31 < 32;
    }

    function optimizedPreferNotEqualOverGtLt()
        external
        pure
        returns (bool notThirtyTwo)
    {
        /// 🚀 Optimized
        notThirtyTwo = 31 != 32;
    }

}
