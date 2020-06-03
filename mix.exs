defmodule Jenkiexs.MixProject do
  use Mix.Project

  def project do
    [
      app: :jenkiexs,
      version: "0.9.3",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      source_url: "https://github.com/GPrimola/jenkiexs",
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
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
end
