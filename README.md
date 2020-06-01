# Jenkiexs

This is a [Jenkins](https://www.jenkins.io/) client written in Elixir.

## Usage

```config
config :jenkiexs, :client,
  url: "http://jenkins.url",
  username: "username",
  token: "1a2b3c4d5e6f"
```

## Documentation

The documentation will be at HexDocs [Jenkiexs](https://hexdocs.pm/jenkiexs/Jenkiexs.html#content)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `jenkiexs` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:jenkiexs, "~> 0.9.2"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/jenkiexs](https://hexdocs.pm/jenkiexs).
