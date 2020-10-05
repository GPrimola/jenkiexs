defmodule Jenkiexs.MixProject do
  use Mix.Project

  @version "0.9.4"
  @source_url "https://github.com/GPrimola/jenkiexs"

  def project do
    [
      app: :jenkiexs,
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      description: "Jenkins client written in Elixir",
      package: package(),
      deps: deps(),
      docs: docs(),
      elixirc_paths: elixirc_paths(Mix.env()),
      source_url: @source_url,
      homepage_url: "https://hex.pm/packages/jenkiexs"
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
      {:plug_cowboy, "~> 2.0", only: [:test]}
    ]
  end

  defp docs do
    [
      main: "readme",
      source_url: @source_url,
      logo: "priv/img/jenkiexs-logo.png",
      extras: [
        "README.md"
      ]
    ]
  end

  def package do
    [
      name: "jenkiexs",
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
