# Kyoto Lang

> 京

Lightweight functional programming language designed to have a small memory footprint with a declarative memory usage.

- Documentation website: [link](https://raphamorim.io/kyoto/)
- Kyoto playground: TBD

![Logo Fox Yusuke](docs/resources/logo-rect.png)

Kyoto Language has as primary compilation target: [WebAssembly](https://webassembly.org). It’s built for Web and Server usage, see more on compiler spec part.

## Features

- Primary based on stateless functions
- Lazy evaluation.
- Enforces memory usage only when it’s declared.
- Easy cross compilation when targeting a browser host or a WASI host (like [Wasmtime](https://github.com/bytecodealliance/wasmtime), [Wasmer](https://github.com/wasmerio/wasmer) and etc).

Kyoto allows you to build applications that are platform agnostic since it runs on WebAssembly Virtual Machine. However you can also specify compilation target as C programming language or even JavaScript.

```rust

// Available in
// compilation time
*anotherValue = 5;

// Available in
// runtime and compilation time
yetAnotherValue = 85;

// Exports "myFunction"
pub fn myFunction = mul(2) |> sum(1);

// It will be "transformed"
// into a function that returns 8
pub fn value = 8;

```

You can compile the code above using kyoto compiler and specifying WebAssembly 32 bits and it will produce a .wasm file.

```bash
kyoto main.kto --target wasm32 -o module.wasm
```

It will produce `module.wasm` with the following data:

```bash
0061 736d 0100 0000 010d 0360 0000 6000
017f 6001 7f01 7f03 0403 0001 0205 0301
0001 071c 0303 6d65 6d02 0005 7661 6c75
6500 010a 6d79 4675 6e63 7469 6f6e 0002
0801 000a 1e03 0a00 4100 41d5 003a 0000
0b05 0041 080f 0b0b 0020 0041 026c 4101
6a0f 0b
```

The binary produced above can also be represented as the following code written in WebAssembly text format:

```lisp
(module
  (memory $mem 1)
  (export "mem" (memory $mem))
  (func $kyoto
    (i32.store8 (i32.const 0) (i32.const 0x55))
  )
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
  (start $kyoto)
)
```

For more information please visit the documentation website: [https://raphamorim.io/kyoto/](https://raphamorim.io/kyoto/).
