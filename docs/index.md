---
layout: page
class: page
title: 'Kyoto Programming Language'
language: 'en'
---

<img src="/kyoto/assets/images/logo-small.png" height="200px" />

# Kyoto Programming Language

Lightweight functional programming language designed to have a small memory footprint with a declarative memory usage. The VCS of the compiler language is [github.com/raphamorim/kyoto](https://github.com/raphamorim/kyoto).

Kyoto Language has as primary compilation target: [WebAssembly](https://webassembly.org). It’s built for Web and Server usage, see more on compiler spec part.

It allows you to build applications that are platform agnostic since it runs on WebAssembly Virtual Machine. You can also specify compilation target as C programming language or even JavaScript.

{% highlight rust %}
// Available in compilation time
*anotherValue = 5;

// Available in runtime and compilation time
yetAnotherValue = 85;

// Exports "myFunction"
export fn myFunction = mul(2) |> sum(1);

// It will be "transformed" into a function that returns 8
export fn value = 8;

{% endhighlight %}

## Summary

- [1. Overview](overview)
- [2. Features](features)
- [3. Types](types)