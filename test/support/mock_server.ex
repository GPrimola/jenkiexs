defmodule Jenkiexs.MockServer do
  def start do
    case Process.whereis(__MODULE__) do
      nil -> start_server()
      pid -> {:ok, pid}
    end
  end

  defp start_server() do
    config = Application.get_env(:jenkiexs, :mock_server)
    jenkins_config = config[:jenkins]

    children = [
      {Plug.Cowboy,
       scheme: :http,
       plug: Jenkiexs.MockServer.Jenkins,
       options: [port: Keyword.get(jenkins_config, :port)]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: __MODULE__)
  end

  defmacro __using__(_opts) do
    quote do
      import Jenkiexs.Factory
      use Plug.Router

      plug(Plug.Parsers,
        parsers: [:json],
        json_decoder: Jason,
        pass: ["*/*"]
      )

      plug(:match)
      plug(:dispatch)
    end
  end
end
