# Kyoto 京

> ポータブルバイナリコードアセンブリのコンパイルに重点を置いて作成された並列プログラミング言語。

Lightweight programming language (designed to have very small memory footprint and with minimalist syntax and features) powered by [LLVM](https://en.wikipedia.org/wiki/LLVM) that have as compilation target: [WebAssembly](https://webassembly.org).

### Features

- Lazy and async collections with streams

### Example Code

*main.kto*

```erl
"1" |> String.toInteger |> sum(2) |> log
# 3
```

### WebAssembly

WebAssembly (abbreviated Wasm) is a binary instruction format for a stack-based virtual machine. Wasm is designed as a portable target for compilation of high-level languages like C/C++/Rust, enabling deployment on the web for client and server applications.

##### Usage with WASM

Kyoto is made and focused exclusively for WASM usage. Here's an example using Kyoto Webpack loader:

```jsx
import fib from 'fib.kto';

console.log(fib(13))
```

## TODO

- [ ] Primitive Types
 - [ ] Interger
   - [ ] `int8` (8-bit signed integer)
   - [ ] `uint8` (8-bit unsigned integer)
   - [ ] `int16`
   - [ ] `uint16`
   - [ ] `int32`
   - [ ] `uint32`
   - [ ] `int64`
   - [ ] `uint64`
 - [ ] `String` (utf-8 encoded textual data type)
