# Bcryptrs

Bcryptrs is a drop in replacement for bcrypt_elixir
It uses rustler precompiled and does not require C compiler in yoyur image
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bcryptrs` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bcryptrs, "~> 0.1.0"}
  ]
end
```

## Usage in tests:

add to your `config/test.exs` do run the tests faster
4 is the minimum cost. Any value that's lower won't work

```elixir
config :bcryptrs, cost: 4
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bcrypt_rs>.

