# Kyoto 京

> ポータブルバイナリコードアセンブリのコンパイルに重点を置いて作成された並列プログラミング言語。

Lightweight programming language (designed to have very small memory footprint and with minimalist syntax and features) powered by [LLVM](https://en.wikipedia.org/wiki/LLVM) that have as compilation target: [WebAssembly](https://webassembly.org).

<img src="resources/logo.png" width="140" />

### Features

- Lazy and async collections with streams.
- Built-in types based on unsigned memory.
- [Memory lifecycle](#memory-usage).
- Enforces use more memory only when it's really necessary.

### Example Code

*main.kto*

```erl
"1" |> String.toInt |> sum(2) |> log
# 3
```

*fib.kto*

```go
fn fibonacci() fn() Int64 {
    x, y := 0, 1
    <- fn() Int64 {
        x, y = y, x + y
        <- y - x
    }
}
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

- [ ] Built-in types
  - [ ] `Int` (8-bit unsigned integer)
    - Min: `–128`, Max: `127`
    - [ ] `toString`
  - [ ] `Int16` (16-bit unsigned integer)
    - Min: `–32768`, Max: `32767`
    - [ ] `toString`
  - [ ] `Int32` (16-bit unsigned integer)
    - Min: `–2147483648`, Max: `2147483647`
    - [ ] `toString`
  - [ ] `Int64` (64-bit unsigned integer)
    - [ ] `toString`
  - [ ] `Float` (64-bit unsigned float)
    - [ ] `toString`
  - [ ] `Function` (`fn`) A reference to code chunk
- [ ] Data types
  - [ ] `String` (UTF-8 encoded binaries representing characters)


## References

- https://webassembly.github.io/spec/
- https://gnuu.org/2009/09/18/writing-your-own-toy-compiler/
- https://llvm.org/docs/tutorial/OCamlLangImpl1.html
