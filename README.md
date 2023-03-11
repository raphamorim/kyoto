# Kyoto Lang

> 京

Lightweight functional programming language designed to have a small memory footprint with a declarative memory usage.

![Logo Fox Yusuke](resources/logo-rect.png)

Kyoto Language has as primary compilation target: [WebAssembly](https://webassembly.org). It’s built for Web and Server usage, see more on compiler spec part.

Kyoto allows you to build applications that are platform agnostic since it runs on WebAssembly Virtual Machine. However you can also specify compilation target as C programming language or even JavaScript.

```rust

// pub keyword always enforce function exported type. Which means that “value” will be transformed into a function that returns 8
pub value = 8

// This value will be available only in compilation time
anotherValue = 5

// This value will be available to use on runtime and compilation time
mem yetAnotherValue =  85

// Exports “myFunction”
pub myFunction = mul(2) |> sum(1)

```

You can compile the code above using kyoto compiler and specifying WebAssembly 32 bits and it will produce a .wasm file.

```bash
kyoto main.kto - -target wasm32
```

The binary produced above can also be represented as the following code written in WebAssembly text format:

```lisp
(module
  (func (export “value”) (result i32)
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

## Features

- Primary based on stateless functions
- Tail call optimisation 
- Lazy and async collections with streams.
- Built-in types based on unsigned memory.
- Enforces memory usage only when it’s declared.

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


## TODO `Kyoto 0.1.0`

#### Types

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
  - [ ] `Map`
  - [ ] `List`
