# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :jenkiexs, :client,
  url: "http://localhost:8888",
  username: "test",
  token: "test"

config :jenkiexs, :mock_server,
  jenkins: [
    port: 8888
  ]
