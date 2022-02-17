// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

import "ds-test/test.sol";

import "./../contracts/unoptimized/CacheArrLength.sol";
import "./../contracts/unoptimized/PlusPlusIndex.sol";
import "./../contracts/unoptimized/Reentrancy.sol";
import "./../contracts/unoptimized/DivideByTwo.sol";
import "./../contracts/unoptimized/UncheckedIncrement.sol";
import "./../contracts/unoptimized/UseImmutable.sol";
import "./../contracts/unoptimized/RequireNeZero.sol";
import "./../contracts/unoptimized/PayableFunctions.sol";
import "./../contracts/unoptimized/ArrayPlus.sol";

contract Test is DSTest {
    CacheArrLength public ctrctCacheArrLength;
    PlusPlusIndex public ctrctPlusPlusIndex;
    UncheckedIncrement public ctrctUncheckedIncrement;
    Reentrancy public ctrctReentrancy;
    DivideByTwo public ctrctDivideByTwo;
    UseImmutable public ctrctUseImmutable;
    RequireNeZero public ctrctRequireNeZero;
    PayableFunctions public ctrctPayableFunctions;
    ArrayPlus public ctrctArrayPlus;

    function setUp() public {
        ctrctCacheArrLength = new CacheArrLength();
        ctrctPlusPlusIndex = new PlusPlusIndex();
        ctrctUncheckedIncrement = new UncheckedIncrement();
        ctrctReentrancy = new Reentrancy();
        ctrctDivideByTwo = new DivideByTwo();
        ctrctUseImmutable = new UseImmutable();
        ctrctRequireNeZero = new RequireNeZero();
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
