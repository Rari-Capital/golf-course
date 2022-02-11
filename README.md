# ⛳ golf-course
A list of common Solidity optimization tips and myths.

## Table of contents
  - [Tips](#tips)
    - [Operators](#-operators)
    - [Compiler](#-compiler)
  - [Myths](#myths)

## Tips

### ➗ Operators

#### Right Shift Instead of Dividing By 2

The `SHR` opcode is 3 gas cheaper than `DIV` and also bypasses Solidity's division by 0 prevention overhead.

- [Gas Usage]()
- [Full Example]()

```solidity
// 🚩 Unoptimized
uint256 two = 4 / 2;

// 🏌️ Optimized
uint256 two = 4 >> 1;
```

### 🤖 Compiler

#### Function ordering

The compiler orders public and external members of a contract by their Method ID.

You can get the Method ID of a function as follows:

```solidity
bytes4 methodId = bytes4(keccak256("<function_signature>"));
```

Calling a function at runtime will be cheaper if the function is positioned earlier in the order (has a relatively lower Method ID) because 22 gas are added to the cost of a function for every position that came before it. The caller can save on gas if you prioritize most called functions.

[This tool](https://emn178.github.io/solidity-optimize-name/) helps you find alternative function names with lower Method IDs.

- [Gas Usage]()
- [Full Example]()

```solidity
// 🚩 Unoptimized
// Method ID: 0x13216062 (position: 1, gas: 98)
bytes32 public occasionallyCalled;
// Method ID: 0xd0755f53 (position: 3, gas: 142)
function mostCalled() external {}
// Method ID: 0x24de5553 (position: 2, gas: 120)
function leastCalled() external {}

// 🏌️ Optimized
// Method ID: 0x13216062 (position: 2, gas: 120)
bytes32 public occasionallyCalled;
// Method ID: 0x0000a818 (position: 1, gas: 98) 👈
function mostCalled_41q() external {}
// Method ID: 0x24de5553 (position: 3, gas: 142)
function leastCalled() external {}
```

## Myths
