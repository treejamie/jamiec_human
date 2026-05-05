[Pattern matching][1] is one of [Elixir's][1] most powerful features — and also one of the first things that trips up [developers coming from object-oriented languages][2]. This post walks through the essentials.

## What Is Pattern Matching?

In most languages[^1], `=` means assignment. In Elixir, it's a **match operator**. The runtime tries to make the left side equal the right side, and raises an error if it can't.

> "In Elixir, the equals sign is not an assignment. Instead it's like an assertion."
> — Dave Thomas, *Programming Elixir*

## Basic Examples

Matching a simple value:

```elixir
x = 1
1 = x  # works fine
2 = x  # raises MatchError
```

Destructuring a tuple:

```elixir
{:ok, result} = {:ok, 42}
IO.inspect(result)  # => 42
```

Matching on lists:

```elixir
[head | tail] = [1, 2, 3]
IO.inspect(head)  # => 1
IO.inspect(tail)  # => [2, 3]
```

## The Pin Operator

Use `^` when you want to match *against* an existing variable rather than rebind it:

```elixir
x = 5
^x = 5  # ok
^x = 6  # MatchError
```

## When to Use It

Pattern matching[^2] shines in several scenarios:

- **Function heads** — define multiple clauses that match on argument shape
- **`case` expressions** — branch cleanly without nested `if/else`
- **Unpacking results** — destructure `{:ok, val}` and `{:error, reason}` inline
- **Guards** — combine with `when` for fine-grained control

### Function Head Example

```elixir
defmodule Greeter do
  def greet({:english, name}), do: "Hello, #{name}!"
  def greet({:french, name}),  do: "Bonjour, #{name}!"
  def greet({_, name}),        do: "Hi, #{name}!"
end
```

## Going Deeper

The [official Elixir docs on pattern matching](https://hexdocs.pm/elixir/pattern-matching.html) are excellent. José Valim's original design notes are also worth reading if you want to understand the *why* behind the semantics.

For a visual overview of how match errors propagate through a supervision tree:


![IMG_2560.jpeg](https://media.jamiecurle.com/e99a2fac-6c84-44e8-882a-5e3fda157d5e.jpeg "title yes")

## A Quick Reference Table

| Syntax | What it does |
|---|---|
| `{a, b} = {1, 2}` | Destructure a tuple |
| `[h \| t] = list` | Split head and tail |
| `^x = val` | Match without rebinding |
| `%{key: v} = map` | Extract a map value |

## Summary

Pattern matching isn't just a feature — it's a mindset shift. Once it clicks, you'll find yourself reaching for it constantly: in function signatures, in `case` and `with` blocks, and anywhere you'd otherwise write defensive nil checks.

---




*Next up: [Using `with` for happy-path pipelines](#) and how it composes with pattern matching.*



[0]: https://hexdocs.pm/elixir/pattern-matching.html
[1]: https://elixir-lang.org/docs.html
[2]: https://en.wikipedia.org/wiki/Object-oriented_programming


[^1]: Obvioulsy, this is a mistake.
[^2]: And when there's more to add into a footnote, like a crazy amount of details
  it's customary to use an indent to get the footnote to span many many lines of
  text.
