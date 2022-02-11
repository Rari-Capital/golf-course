// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.4;

import {UnoptimizedFunctionOrdering, OptimizedFunctionOrdering} from "src/FunctionOrdering.sol";
import "ds-test/test.sol";

contract FunctionOrderingTest is DSTest {
    UnoptimizedFunctionOrdering unoptimizedFunctionOrdering;
    OptimizedFunctionOrdering optimizedFunctionOrdering;

    function setUp() public {
        unoptimizedFunctionOrdering = new UnoptimizedFunctionOrdering();
        optimizedFunctionOrdering = new OptimizedFunctionOrdering();
    }

    function testUnoptimizedFunctionOrdering() public {
        unoptimizedFunctionOrdering.mostCalled();
        unoptimizedFunctionOrdering.mostCalled();
        unoptimizedFunctionOrdering.mostCalled();
        unoptimizedFunctionOrdering.occasionallyCalled();
        unoptimizedFunctionOrdering.occasionallyCalled();
        unoptimizedFunctionOrdering.leastCalled();
    }

    function testOptimizedFunctionOrdering() public {
        optimizedFunctionOrdering.mostCalled_41q();
        optimizedFunctionOrdering.mostCalled_41q();
        optimizedFunctionOrdering.mostCalled_41q();
        optimizedFunctionOrdering.occasionallyCalled();
        optimizedFunctionOrdering.occasionallyCalled();
        optimizedFunctionOrdering.leastCalled();
    }
}
