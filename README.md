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

## Myths
