# golf-course
A list of common Solidity optimization tips and myths.


# Tips

- - - -
### Use UINT instead of BOOL for reentrancy guard ###

```solidity
/// 🤦 Unoptimized (gas: 22180)

bool private locked = false;
modifier nonReentrant() {
    require(locked == 1, "REENTRANCY");
    locked = 2;
    _;
    locked = 1;
}

/// 🚀 Optimized (gas: 2053)
bool private locked = 1;
modifier nonReentrant() {
    require(locked == 1, "REENTRANCY");
    locked = 2;
    _;
    locked = 1;
}
```

Use a reentrancy guard like [Solmate](https://github.com/Rari-Capital/solmate/blob/main/src/utils/ReentrancyGuard.sol) which employs uint instead of boolean storage variable which saves gas.
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/OptimizedReentrancy.sol)

- - - -
### When iterating through a storage array, cache the array length first ###

```solidity
uint256[] public arr = [uint256(1), 2, 3, 4, 5, 6, 7, 8, 9, 10];

/// 🤦 Unoptimized (gas: 3077)
for (uint256 index; index < arr.length; ++index) {}

/// 🚀 Optimized (gas: 2085)
uint256 arrLength = arr.length;
for (uint256 index; index < arrLength; ++index) {}
```
Caching the array length first saves an SLOAD on each iteration of the loop.
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/OptimizedCacheArrLength.sol)

- - - -
### Use unchecked with counter incrementing logic ###

```solidity

/// 🤦 Unoptimized (gas: 1990)
for (uint256 index; index < arrLength; ++index) {}


/// 🚀 Optimized (gas: 1315)
function _uncheckedIncrement(uint256 counter) private pure returns(uint256) {
    unchecked {
        return counter + 1;
    }
}
...
for (uint256 index; index < arrLength; index = _uncheckedIncrement(index)) {}
```
It is a logical impossibility for index to overflow if it is always less than another integer (index < arrLength).  Skipping the unchecked saves ~60 gas per iteration.  Note: Part of the savings here comes from the fact that as of Solidity 0.8.2, the compiler will inline this function automatically.  Using an older pragma would reduce the gas savings. For additional info see [hrkrshnn's writeup](https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc)
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/OptimizedUncheckedIncrement.sol)


- - - -
### Use ++index instead of index++ to increment a loop counter ###

```solidity
/// 🤦 Unoptimized (gas: 2064)
for (uint256 index; index < arrLength; index++) {}

/// 🚀 Optimized (gas: 2014)
for (uint256 index; index < arrLength; ++index) {}
```
Due to reduced stack operations, using ++index saves 5 gas per iteration
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/OptimizedPlusPlusIndex.sol)

- - - -
### Prefer using immutable to storage ###

```solidity
uint256 public immutableNumber;
uint256 public storageNumber;

/// 🤦 Unoptimized (gas: 1042)
uint256 sum = storageNumber + 1;
    }
/// 🚀 Optimized (gas: 1024)
uint256 sum = immutableNumber + 1;
```
Each storage read of the state variable is replaced by the instruction push32 value, where value is set during contract construction time. For additional info see [hrkrshnn's writeup](https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc)
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/OptimizedUseImmutable.sol)

- - - -
### When dividing by two, use `>> 1` instead of `/ 2` ###

```solidity
uint256 four = 4;
uint256 two;

/// 🤦 Unoptimized (gas: 942)
two = four / 2;

/// 🚀 Optimized (gas: 866)
two = four >> 1;
```

The `SHR` opcode is 3 gas cheaper than `DIV` and more imporantly, bypasses Solidity's division by 0 prevention overhead.  This can be used not only when dividing by two, but with any exponent of 2.
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/OptimizedDivideByTwo.sol)




# Myths
- - - -

- - - -
### Note on gas numbers:  The gas usage numbers include the total gas reported by Dapp Test for running a test which calls the example function.  This includes the gas overhead of the test itself.  The important number here is the gas savings which is the difference between optimized and unoptimized gas usage numbers.  We have done our best to reduce noise in the estimates and confirm the actual gas usage based on opcodes run.  But there have still been some inconsistencies in the gas numbers between the two contracts used for testing.

