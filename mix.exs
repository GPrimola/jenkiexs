defmodule Jenkiexs.MixProject do
  use Mix.Project

  def project do
    [
      app: :jenkiexs,
      version: "0.9.4",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      source_url: "https://github.com/GPrimola/jenkiexs",
      homepage_url: "https://hex.pm/packages/jenkiexs",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", runtime: false},
      {:ex_machina, "~> 2.4", only: [:test]},
      {:plug_cowboy, "~> 2.0", only: [:test]},
      {:excoveralls, "~> 0.13.2", only: :test}
    ]
  end

  def package do
    [
      name: "jenkiexs",
      description: """
      This is a [Jenkins](https://www.jenkins.io/) client written in Elixir.
      """,
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/GPrimola/jenkiexs"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
