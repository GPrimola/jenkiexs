# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger,
  level: :debug,
  backends: [
    :console
  ],
  handle_otp_reports: false,
  handle_sasl_reports: false,
  compile_time_application: true

config :jenkiexs, :client,
  url: System.get_env("JENKINS_URL"),
  username: System.get_env("JENKINS_USERNAME"),
  token: System.get_env("JENKINS_TOKEN")
