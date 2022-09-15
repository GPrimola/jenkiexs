# Jenkiexs

![CI](https://github.com/GPrimola/jenkiexs/workflows/Jenkiexs%20Master%20CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/GPrimola/jenkiexs/badge.svg?branch=master)](https://coveralls.io/github/GPrimola/jenkiexs?branch=master)
[![Docs](https://img.shields.io/badge/api-docs-blueviolet.svg?style=flat)](https://hexdocs.pm/jenkiexs)
![Hex.pm](https://img.shields.io/hexpm/v/jenkiexs)


[Jenkins](https://www.jenkins.io/) client written in Elixir.

---


### WELCOME HACKTOBERFEST 2022 PARTYPEOPLE!! 🎉🎊🥳👩🏿‍💻👩🏾‍💻👩🏽‍💻👩🏼‍💻👩🏻‍💻👩‍💻👨‍💻👨🏻‍💻👨🏼‍💻👨🏽‍💻👨🏾‍💻👨🏿‍💻

#### Here are some few things I'd like to ask you beforehand for this event!

##### Basic Code of Conduct
1. Be nice to other people, no matter what, should you interact with anyone here on GitHub or outside.

   - Keep in mind: everybody is doing their best, so there's no reason to be harsh to anyone.

2. Open **short**, but **meaningful** and **valuable**, **PR**(s). This way is easier to review on time.

   - E.g.: Instead of document a whole module, you can document just one function, for instance. This goes with the Quality over Quantity value from Hacktoberfest.

3. This is a fresh repository which I'm already using in production. I apologize for the lack of more information but feel free to interact with me through the Issues or [twitter](https://twitter.com/lu_gico) with the hashtag #elixirJenkiexs.

#### Let the hack begin! 🦜

#### We appreciate your collaboration! Thank you very much!! 🙏🏿🙏🏾🙏🏽🙏🏼🙏🏻🙏✨

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
