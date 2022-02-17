// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

import "ds-test/test.sol";

import "./../contracts/optimized/CacheArrLength.sol";
import "./../contracts/optimized/Reentrancy.sol";
import "./../contracts/optimized/DivideByTwo.sol";
import "./../contracts/optimized/PlusPlusIndex.sol";
import "./../contracts/optimized/UncheckedIncrement.sol";
import "./../contracts/optimized/UseImmutable.sol";
import "./../contracts/optimized/RequireNeZero.sol";
import "./../contracts/optimized/ArrayPlus.sol";
import "./../contracts/optimized/PayableFunctions.sol";

contract Test is DSTest {
    Reentrancy public ctrctReentrancy;
    CacheArrLength public ctrctCacheArrLength;
    PlusPlusIndex public ctrctPlusPlusIndex;
    UncheckedIncrement public ctrctUncheckedIncrement;
    UseImmutable public ctrctUseImmutable;
    RequireNeZero public ctrctRequireNeZero;
    DivideByTwo public ctrctDivideByTwo;
    PayableFunctions public ctrctPayableFunctions;
    ArrayPlus public ctrctArrayPlus;

    function setUp() public {
        ctrctReentrancy = new Reentrancy();
        ctrctCacheArrLength = new CacheArrLength();
        ctrctPlusPlusIndex = new PlusPlusIndex();
        ctrctUseImmutable = new UseImmutable();
        ctrctRequireNeZero = new RequireNeZero();
        ctrctUncheckedIncrement = new UncheckedIncrement();
        ctrctDivideByTwo = new DivideByTwo();
        ctrctPayableFunctions = new PayableFunctions();
        ctrctArrayPlus = new ArrayPlus();
    }

    function testArrayPlus() public {
        ctrctArrayPlus.arrayPlus();
    }

    function testPayableFunctions() public {
        ctrctPayableFunctions.payableFunctions();
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
