// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./GolfCourse.sol";

contract GolfCourseTest is DSTest {
    GolfCourse course;

    function setUp() public {
        course = new GolfCourse();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
