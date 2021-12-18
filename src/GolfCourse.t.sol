// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./GolfCourse.sol";

contract GolfCourseTest is DSTest {
    GolfCourse course;

    function setUp() public {
        course = new GolfCourse();
    }

    function testUnoptimizedDivideByTwo() public {
        assertEq(course.unoptimizedDivideByTwo(), 2);
    }

    function testOptimizedDivideByTwo() public {
        assertEq(course.optimizedDivideByTwo(), 2);
    }

    function testUnoptimizedPreferGteLteOverGtLt() public {
        assertTrue(course.unoptimizedPreferGteLteOverGtLt());
    }

    function testOptimizedPreferGteLteOverGtLt() public {
        assertTrue(course.optimizedPreferGteLteOverGtLt());
    }

    function testUnoptimizedPreferNotEqualOverGtLt() public {
        assertTrue(course.unoptimizedPreferNotEqualOverGtLt());
    }

    function testOptimizedPreferNotEqualOverGtLt() public {
        assertTrue(course.optimizedPreferNotEqualOverGtLt());
    }

    function testUnoptimizedUseCodeLength() public {
        assertTrue(course.unoptimizedUseCodeLength() > 0);
    }

    function testOptimizedUseCodeLength() public {
        assertTrue(course.optimizedUseCodeLength() > 0);
    }
}
