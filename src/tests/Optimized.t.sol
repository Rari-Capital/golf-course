// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

import "ds-test/test.sol";

import "./../contracts/OptimizedCacheArrLength.sol";
import "./../contracts/OptimizedReentrancy.sol";
import "./../contracts/OptimizedDivideByTwo.sol";
import "./../contracts/OptimizedPlusPlusIndex.sol";
import "./../contracts/OptimizedUncheckedIncrement.sol";
import "./../contracts/OptimizedUseImmutable.sol";
import "./../contracts/OptimizedRequireNeZero.sol";

contract OptimizedTest is DSTest {
    OptimizedReentrancy public ctrctReentrancy;
    OptimizedCacheArrLength public ctrctCacheArrLength;
    OptimizedPlusPlusIndex public ctrctPlusPlusIndex;
    OptimizedUncheckedIncrement public ctrctUncheckedIncrement;
    OptimizedUseImmutable public ctrctUseImmutable;
    OptimizedRequireNeZero public ctrctRequireNeZero;
    OptimizedDivideByTwo public ctrctDivideByTwo;

    function setUp() public {
        ctrctReentrancy = new OptimizedReentrancy();
        ctrctCacheArrLength = new OptimizedCacheArrLength();
        ctrctPlusPlusIndex = new OptimizedPlusPlusIndex();
        ctrctUseImmutable = new OptimizedUseImmutable();
        ctrctRequireNeZero = new OptimizedRequireNeZero();
        ctrctUncheckedIncrement = new OptimizedUncheckedIncrement();
        ctrctDivideByTwo = new OptimizedDivideByTwo();
    }

    function testRequireNeZero() public {
        ctrctRequireNeZero.requireNeZero(4);
    }

    function testCacheArrLength() public {
        ctrctCacheArrLength.cacheArrLength();
    }

    function testPlusPlusIndex() public {
        ctrctPlusPlusIndex.plusPlusIndex();
    }

    function testUncheckedIncrement() public {
        ctrctUncheckedIncrement.uncheckedIncrement();
    }

    function testUseImmutable() public {
        ctrctUseImmutable.useImmutable();
    }

    function testUseUintForReentrancy() public {
        ctrctReentrancy.useUintForReentrancy();
    }

    function testDivideByTwo() public view {
        ctrctDivideByTwo.divideByTwo(4);
    }


}
