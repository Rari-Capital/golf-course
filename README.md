# golf-course
A list of common Solidity optimization tips and myths.

## Tips

### When dividing by two, use `>> 1` instead of `/ 2`

The `SHR` opcode is 3 gas cheaper than `DIV` and also bypasses Solidity's division by 0 prevention overhead.

- [Gas Usage]()
- [Full Example]()

```solidity
// Unoptimized:
uint256 foo = bar / 2;

// Optimized:
uint256 foo = bar >> 1;
```


### Use `>=` and `<=` instead of `>` and `<`

Explanation tbd

- [Gas Usage]()
- [Full Example]()

```solidity
// Unoptimized:
bool foo = bar > 0;

// Optimized:
bool foo = bar >= 1;
```


### Using `!=` is usually cheaper than `>` or `<`

Explanation tbd

- [Gas Usage]()
- [Full Example]()

```solidity
// Unoptimized:
uint256 foo = bar < 32;

// Optimized:
uint256 foo = bar != 32;
```


### Use `<address>.code.length` instead of assembly `extcodesize` to avoid variable overhead

Solidity [0.8.1](https://github.com/ethereum/solidity/blob/develop/Changelog.md#081-2021-01-27) implements a shortcut for `<address>.code.length` that avoids copying code to memory.  More explanation TBD

- [Gas Usage]()
- [Full Example]()

```solidity
// Unoptimized:
uint256 foo;
assembly {
    foo := extcodesize(bar)
}
return foo;

// Optimized:
return bar.code.length;
```


## Myths
