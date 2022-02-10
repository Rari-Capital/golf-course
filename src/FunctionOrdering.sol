// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

contract UnoptimizedFunctionOrdering {
    // Method ID: 0x13216062
    bytes32 public occasionallyCalled;

    // 🤦 Unoptimized
    // Method ID: 0xd0755f53
    function mostCalled() external {}

    // Method ID: 0x24de5553
    function leastCalled() external {}
}

contract OptimizedFunctionOrdering {
    // Method ID: 0x13216062
    bytes32 public occasionallyCalled;

    // 🚀 Optimized
    // Method ID: 0x0000a818
    function mostCalled_41q() external {}

    // Method ID: 0x24de5553
    function leastCalled() external {}
}
