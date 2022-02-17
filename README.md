# golf-course
A list of common Solidity optimization tips and myths.


# Tips

- - - -
### Use `uint` instead of `bool` for reentrancy guard ###

```solidity
/// 🤦 Unoptimized (gas: 22202)

bool private locked = false;
modifier nonReentrant() {
    require(locked == false, "REENTRANCY");
    locked = true;
    _;
    locked = false;
}

/// 🚀 Optimized (gas: 2125)
bool private locked = 1;
modifier nonReentrant() {
    require(locked == 1, "REENTRANCY");
    locked = 2;
    _;
    locked = 1;
}
```

Use a reentrancy guard like [Solmate](https://github.com/Rari-Capital/solmate/blob/main/src/utils/ReentrancyGuard.sol) which employs `uint` instead of `bool` storage variable which saves gas.  The initial `SSTORE` of _true_ in the unoptimized version costs over 20,000 gas while the second SSTORE of _false_ costs only 100.  But both `SSTORE` (for 2 and 1) cost only 100 gas.
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/Reentrancy.sol)

- - - -
### When iterating through a storage array, cache the array length first ###

```solidity
uint256[] public arr = [uint256(1), 2, 3, 4, 5, 6, 7, 8, 9, 10];

/// 🤦 Unoptimized (gas: 3055)
for (uint256 index; index < arr.length; ++index) {}

/// 🚀 Optimized (gas: 2013)
uint256 arrLength = arr.length;
for (uint256 index; index < arrLength; ++index) {}
```
Caching the array length first saves an `SLOAD` on each iteration of the loop.
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/CacheArrLength.sol)

- - - -
### Use unchecked with counter incrementing logic ###

```solidity

/// 🤦 Unoptimized (gas: 2035)
for (uint256 index; index < arrLength; ++index) {}


/// 🚀 Optimized (gas: 1375)
function _uncheckedIncrement(uint256 counter) private pure returns(uint256) {
    unchecked {
        return counter + 1;
    }
}
...
for (uint256 index; index < arrLength; index = _uncheckedIncrement(index)) {}
```
It is a logical impossibility for index to overflow if it is always less than another integer (`index < arrLength`).  Skipping the unchecked saves ~60 gas per iteration.  Note: Part of the savings here comes from the fact that as of Solidity 0.8.2, the compiler will inline this function automatically.  Using an older pragma would reduce the gas savings. For additional info see [hrkrshnn's writeup](https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc)
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/UncheckedIncrement.sol)


- - - -
### Use `++index` instead of `index++` to increment a loop counter ###

```solidity
/// 🤦 Unoptimized (gas: 2064)
for (uint256 index; index < arrLength; index++) {}

/// 🚀 Optimized (gas: 2014)
for (uint256 index; index < arrLength; ++index) {}
```
Due to reduced stack operations, using `++index` saves 5 gas per iteration
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/PlusPlusIndex.sol)

- - - -
### Prefer using `immutable` to `storage` ###

```solidity
uint256 public immutableNumber;
uint256 public storageNumber;

/// 🤦 Unoptimized (gas: 1042)
uint256 sum = storageNumber + 1;
    }
/// 🚀 Optimized (gas: 1024)
uint256 sum = immutableNumber + 1;
```
Each storage read of the state variable is replaced by the instruction `PUSH32` value, where value is set during contract construction time. For additional info see [hrkrshnn's writeup](https://gist.github.com/hrkrshnn/ee8fabd532058307229d65dcd5836ddc)
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/UseImmutable.sol)

- - - -
### Make functions `payable` ###

```solidity

/// 🤦 Unoptimized (gas: 781)
function doSomething() external pure {}

/// 🚀 Optimized (gas: 760)
function doSomething() payable external {}
```
Making functions `payable` eliminates the need for an initial check of `msg.value == 0` and saves 21 gas. Note: This conservatively assumes the function could be `pure` if not for the `payable`.  When compared against a non-`pure` function the savings is more (24 gas). When used for a constructor, the savings is on deployment. Note: For certain contracts, adding a `payable` function where none existed previously could introduce a security risk. Use with caution.
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/PayableFunctions.sol)

- - - -
### For array elements, arr[i] = arr[i] + 1 is cheaper than arr[i] += 1 ###

```solidity
uint256[2] public arr = [uint256(1), 2]; // storage

/// 🤦 Unoptimized (gas: 1110)
arr[0] += 1;

/// 🚀 Optimized (gas: 1085)
arr[0] = arr[0] + 1;
```
Due to stack operations this is 25 gas cheaper when dealing with arrays in storage, and 4 gas cheaper for memory arrays.
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/ArrayPlus.sol)

- - - -
### When dividing by two, use `>> 1` instead of `/ 2` ###

```solidity
uint256 four = 4;
uint256 two;

/// 🤦 Unoptimized (gas: 1012)
two = four / 2;

/// 🚀 Optimized (gas: 933)
two = four >> 1;
```

The `SHR` opcode is 3 gas cheaper than `DIV` and more imporantly, bypasses Solidity's division by 0 prevention overhead.  This can be used not only when dividing by two, but with any exponent of 2.
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/DivideByTwo.sol)


- - - -
### In `require()`, use `!= 0` instead of `> 0` with `uint` values ###

```solidity
uint256 notZero = 4;

/// 🤦 Unoptimized (gas: 867)
require(notZero > 0);

/// 🚀 Optimized (gas: 861)
require(notZero != 0);
```
In a require, when checking a `uint`, using `!= 0` instead of `> 0` saves 6 gas. Note: This only works in require but not in other situations.  For more info see [this thread](https://twitter.com/transmissions11/status/1469848358558711808?s=20&t=hyTZxmZKXq06opE8wgo1aA)
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/optimized/RequireNeZero.sol)




# Myths
- - - -



