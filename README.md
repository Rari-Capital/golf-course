# golf-course
A list of common Solidity optimization tips and myths.

# Tips

- - - -
### 1.  When dividing by two, use `>> 1` instead of `/ 2` ###

```solidity
/// 🤦 Unoptimized:
uint256 two = 4 / 2;

/// 🚀 Optimized:
uint256 two = 4 >> 1;
```

The `SHR` opcode is 3 gas cheaper than `DIV` and also bypasses Solidity's division by 0 prevention overhead.
  - [Gas Usage]()
  - [Full Example]()


- - - -

### 2.  Use `>=` and `<=` instead of `>` and `<` ###
```solidity
/// 🤦 Unoptimized:
if (someInteger > 0) {
    emit GreaterThanZero()
};

/// 🚀 Optimized:
if (someInteger >= 1) {
    emit GreaterThanZero()
};
```

`if (x >= y) {}` is algebraically equivalent to !(x < y) which gets compiled to `LT .. JUMPI` which is more efficient than `x > y` which contains an extra `ISZERO`

- [Gas Usage]()
- [Full Example]()

- - - -

### 3. Using `!=` is usually cheaper than `>` or `<` ###
```solidity
/// 🤦 Unoptimized:
if (bytesCount < 32) {
    emit NotThirtyTwo();
}

/// 🚀 Optimized:
if (bytesCount != 32) {
    emit NotThirtyTwo();
}
```
Similar to `>=` and `<=` - the `!=` gets compiled without an extra ISZERO in many cases (One notable exception being `x != 0` gets compiled the same as `x > 0`)

- [Gas Usage]()
- [Full Example]()



- - - -

### 4. Use `<address>.code.length` instead of assembly `extcodesize` to avoid variable overhead ###
```solidity
/// 🤦 Unoptimized:
uint256 size;
assembly {
    size := extcodesize(someAddress)
}
return size;

/// 🚀 Optimized:
return bar.code.length;
```
Solidity [0.8.1](https:///github.com/ethereum/solidity/blob/develop/Changelog.md#081-2021-01-27) implemented `<address>.code.length` so the assembly is no longer needed

- [Gas Usage]()
- [Full Example]()

- - - -

# Myths
