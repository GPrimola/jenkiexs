defmodule Jenkiexs.MockServer.Jenkins do
  use Jenkiexs.MockServer

  get "/api/json" do
    cond  do
      is_nil(conn.params["tree"]) -> nil

      String.match?(conn.params["tree"], ~r/\Ajobs/) ->
        "jobs[name,description,fullName,displayName,fullDisplayName,inQueue,buildable,disabled,nextBuildNumber,property[parameterDefinitions[name,defaultParameterValue[value]]]]"
    end
  end

  get "/job/:job_name/api/json" do
    case conn.params["job_name"] do
      job -> true
    end
  end

  post "/job/:job_name/build" do
    case conn.params["job_name"] do
      job -> true
    end
  end

  post "/job/:job_name/buildWithParameters" do
    send_resp(conn, 200, Jason.encode!(%{token: "token", apiKey: "apiKey"}))
  end

  defp config() do
    :jenkiexs
    |> Application.get_env(:mock_server)
    |> Keyword.get(:jenkins, [])
  end
end
