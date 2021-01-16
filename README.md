# Jenkiexs

![CI](https://github.com/GPrimola/jenkiexs/workflows/Jenkiexs%20Master%20CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/GPrimola/jenkiexs/badge.svg?branch=master)](https://coveralls.io/github/GPrimola/jenkiexs?branch=master)
[![Docs](https://img.shields.io/badge/api-docs-blueviolet.svg?style=flat)](https://hexdocs.pm/jenkiexs)
![Hex.pm](https://img.shields.io/hexpm/v/jenkiexs)


[Jenkins](https://www.jenkins.io/) client written in Elixir.

---

## Installation

Add `jenkiexs` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:jenkiexs, "~> 1.0.1"}
  ]
end
```

## Usage

You can export `JENKINS_URL`, `JENKINS_USERNAME` and `JENKINS_TOKEN` env vars;
or

```elixir
config :jenkiexs, :client,
  url: "http://jenkins.url",
  username: "username",
  token: "1a2b3c4d5e6f"
```

Note: be aware that if you have both set, preference will be for the application configuration, rather than env vars.
