defmodule Jenkiexs.MockServer.Jenkins do
  use Jenkiexs.MockServer

  get "/api/json" do
    cond do
      is_nil(conn.params["tree"]) ->
        nil

      String.match?(conn.params["tree"], ~r/\Ajobs/) ->
        "jobs[name,description,fullName,displayName,fullDisplayName,inQueue,buildable,disabled,nextBuildNumber,property[parameterDefinitions[name,defaultParameterValue[value]]]]"
    end
  end

  get "/job/:job_name/api/json" do
    case conn.params["job_name"] do
      _job -> true
    end
  end

  get "/job/:job_name/lastBuild/api/json" do
    case conn.params["job_name"] do
      "success_job" ->
        send_resp(conn, 200, Jason.encode!(build(:build)))

      "not_found_job" ->
        send_resp(conn, 404, "")

      _ ->
        send_resp(conn, 500, "something went wrong")
    end
  end

  get "/job/:job_name/:build_number/api/json" do
    case conn.params do
      %{"job_name" => "success_job", "build_number" => "42"} ->
        send_resp(conn, 200, Jason.encode!(build(:build)))

      %{"job_name" => "not_found_job", "build_number" => "42"} ->
        send_resp(conn, 404, "")

      _ ->
        send_resp(conn, 500, "something went wrong")
    end
  end

  get "/crumbIssuer/api/xml" do
    send_resp(conn, 200, ":")
  end

  post "/job/:job_name/build" do
    case conn.params["job_name"] do
      _job -> true
    end
  end

  post "/job/:job_name/buildWithParameters" do
    send_resp(conn, 200, Jason.encode!(%{token: "token", apiKey: "apiKey"}))
  end
end
