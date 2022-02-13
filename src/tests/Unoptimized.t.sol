// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

import "ds-test/test.sol";

import "./../contracts/UnoptimizedCacheArrLength.sol";
import "./../contracts/UnoptimizedPlusPlusIndex.sol";
import "./../contracts/UnoptimizedReentrancy.sol";
import "./../contracts/UnoptimizedDivideByTwo.sol";
import "./../contracts/UnoptimizedUncheckedIncrement.sol";
import "./../contracts/UnoptimizedUseImmutable.sol";

contract UnoptimizedTest is DSTest {
    UnoptimizedCacheArrLength public ctrctCacheArrLength;
    UnoptimizedPlusPlusIndex public ctrctPlusPlusIndex;
    UnoptimizedUncheckedIncrement public ctrctUncheckedIncrement;
    UnoptimizedReentrancy public ctrctReentrancy;
    UnoptimizedDivideByTwo public ctrctDivideByTwo;
    UnoptimizedUseImmutable public ctrctUseImmutable;

    function setUp() public {
        ctrctCacheArrLength = new UnoptimizedCacheArrLength();
        ctrctPlusPlusIndex = new UnoptimizedPlusPlusIndex();
        ctrctUncheckedIncrement = new UnoptimizedUncheckedIncrement();
        ctrctReentrancy = new UnoptimizedReentrancy();
        ctrctDivideByTwo = new UnoptimizedDivideByTwo();
        ctrctUseImmutable = new UnoptimizedUseImmutable();
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
