defmodule Jenkiexs.MockServer.Jenkins do
  use Jenkiexs.MockServer

  get "/api/json" do
    cond do
      is_nil(conn.params["tree"]) ->
        send_resp(conn, 400, "Bad Request")

      String.match?(conn.params["tree"], ~r/\Ajobs/) ->
        resp = Map.put(%{}, :jobs, build_list(5, :job))
        send_resp(conn, 200, Jason.encode!(resp))
    end
  end

  get "/job/:job_name/api/json" do
    case conn.params["job_name"] do
      "success_job" ->
        job =
          :build
          |> build()
          |> Map.put(:_class, "org.jenkinsci.plugins.workflow.job.WorkflowJob")
          |> Jason.encode!()

        send_resp(conn, 200, job)

      _ ->
        send_resp(conn, 500, "something went wrong")
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

      %{"job_name" => "success_job", "build_number" => number} when number == "-1" ->
        send_resp(
          conn,
          200,
          Jason.encode!(
            build(:build, %{"number" => String.to_integer(number), "building" => false})
          )
        )

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
      "buildable_job" -> send_resp(conn, 201, "")
      "not_buildable_job" -> send_resp(conn, 400, "Not valid request")
      _ -> send_resp(conn, 201, "")
    end
  end

  post "/job/:job_name/buildWithParameters" do
    send_resp(conn, 201, "")
  end
end
