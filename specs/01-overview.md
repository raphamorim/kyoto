# Summary

Kyoto Language has as primary compilation target: [WebAssembly](https://webassembly.org). It’s built for Web and Server usage, see more on compiler spec part.

Kyoto allows you to build applications that are platform agnostic since it runs on WebAssembly Virtual Machine. However you can also specify compilation target as C programming language or even JavaScript.

```rust

// The "pub" keyword always enforce function exported type.
// which means that “value” will be transformed 
// into a function that returns 8.
pub value = 8

// This value will be available only in compilation time
anotherValue = 5

// This value will be available to use 
// on runtime and compilation time
let yetAnotherValue = 85

// Exports “myFunction”
pub myFunction = mul(2) |> sum(1)

```

You can compile the code above using kyoto compiler and specifying WebAssembly 32 bits and it will produce a .wasm file.

```bash
kyoto main.kto --target wasm32
```

The binary produced above can also be represented as the following code written in WebAssembly text format:

```lisp
(module
  (memory $mem 1)
  (export "mem" (memory $mem))
  (i32.store8 (i32.const 0) (i32.const 0x55))
  (func (export "value") (result i32)
   i32.const 8
   return)
  (func (export "myFunction") (param i32) (result i32)
    local.get 0
    i32.const 2
    i32.mul
    i32.const 1
    i32.add
    return)
)
```