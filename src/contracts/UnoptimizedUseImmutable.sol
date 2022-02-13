// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.11;

contract UnoptimizedUseImmutable {
    uint256 public immutableNumber;
    uint256 public storageNumber;

    constructor() {
        immutableNumber = 1;
        storageNumber = 1;
    }
    function useImmutable() external view returns(uint256) {
        return storageNumber + 1;
    }

}
