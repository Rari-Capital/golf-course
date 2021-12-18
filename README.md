# golf-course
A list of common Solidity optimization tips and myths.

# Tips

- - - -
### 1.  When dividing by two, use `>> 1` instead of `/ 2` ###

```solidity
/// 🤦 Unoptimized (gas: 1401)
uint256 two = 4 / 2;

/// 🚀 Optimized (gas: 1372)
uint256 two = 4 >> 1;
```

The `SHR` opcode is 3 gas cheaper than `DIV` and also bypasses Solidity's division by 0 prevention overhead.
  - [Gas Usage]()
  - [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/GolfCourse.t.sol#L15)


- - - -

### 2.  Use `>=` and `<=` instead of `>` and `<` ###
```solidity
/// 🤦 Unoptimized (gas: 1401)
bool positive = 1 > 0;

/// 🚀 Optimized (gas: 1337)
bool positive = 1 >= 1;
```

`if (x >= y) {}` is algebraically equivalent to !(x < y) which gets compiled to `LT .. JUMPI` which is more efficient than `x > y` which contains an extra `ISZERO`

- [Gas Usage]()
- [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/GolfCourse.t.sol#L23)

- - - -

### 3. Using `!=` is usually cheaper than `>` or `<` ###
```solidity
/// 🤦 Unoptimized (gas: 1423)
notThirtyTwo = 31 < 32;

/// 🚀 Optimized (gas: 1426)
notThirtyTwo = 31 != 32;
```
Similar to `>=` and `<=` - the `!=` gets compiled without an extra ISZERO in many cases (One notable exception being `x != 0` gets compiled the same as `x > 0`)

- [Gas Usage]()
- [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/GolfCourse.t.sol#L31)



- - - -

### 4. Use `<address>.code.length` instead of assembly `extcodesize` to avoid variable overhead ###
```solidity
/// 🤦 Unoptimized (gas: 1535)
uint256 size;
address address_ = address(this);
assembly {
    size := extcodesize(address_)
}
return size;

/// 🚀 Optimized (gas: 1582)
return address(this).code.length;
```
Solidity [0.8.1](https:///github.com/ethereum/solidity/blob/develop/Changelog.md#081-2021-01-27) implemented `<address>.code.length` so the assembly is no longer needed

- [Gas Usage]()
- [Full Example](https://github.com/Rari-Capital/golf-course/blob/fc1882bacfec50787d9e9435d59fed4a9091fb21/src/GolfCourse.t.sol#L39)

- - - -

# Myths
