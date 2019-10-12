# Kyoto 京

> ポータブルバイナリコードアセンブリのコンパイルに重点を置いて作成された並列プログラミング言語。

Parallel programming language powered by [LLVM](https://en.wikipedia.org/wiki/LLVM) that have as compilation target: [WebAssembly](https://webassembly.org).

### Features

- Everything is an expression
- Lazy and async collections with streams

### Example Code

```erl
"1" |> String.to_integer() |> sum(2) |> log
# 2
```

### WebAssembly

WebAssembly (abbreviated Wasm) is a binary instruction format for a stack-based virtual machine. Wasm is designed as a portable target for compilation of high-level languages like C/C++/Rust, enabling deployment on the web for client and server applications.


