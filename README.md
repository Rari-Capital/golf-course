# golf-course
A list of common Solidity optimization tips and myths.

## Tips

### Right Shift Instead of Dividing By 2

The `SHR` opcode is 3 gas cheaper than `DIV` and also bypasses Solidity's division by 0 prevention overhead.

- [Gas Usage]()
- [Full Example]()

```solidity
// Unoptimized:
uint256 two = 4 / 2;

// Optimized:
uint256 two = 4 >> 1;
```

### Function ordering

Public and external members are ordered by Method ID during compilation.

Each new position adds another 22 gas to the cost of the function.

```solidity
// Assuming `bar` is called more often than `foo` and `baz`

// Unoptimized:
uint256 public foo;            // 0xc2985578 (2nd) + 22 gas
function bar() public {}       // 0xfebb0f7e (3rd) + 44 gas
function baz() public {}       // 0xa7916fac (1st)

// Optimized:
uint256 public foo;            // 0xc2985578 (3rd) + 44 gas
function bar_T2J() public {}   // 0x0000d7d8 (1st)
function baz() public {}       // 0xa7916fac (2nd) + 22 gas
```

## Myths
