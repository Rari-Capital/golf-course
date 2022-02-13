// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract UnoptimizedReentrancy {
    event GenericEvent();

    bool private locked = false;

    modifier nonReentrant() {
        /// 🤦 Unoptimized
        require(locked == false, "REENTRANCY");
        locked = true;
        _;
        locked = false;
    }

    function useUintForReentrancy() external nonReentrant returns(uint256 amount3) {
        // do some stuff
        uint256 amount1 = 1e18;
        uint256 amount2 = 1e18;
        amount3 = amount1 + amount2;
        emit GenericEvent();
    }

}
