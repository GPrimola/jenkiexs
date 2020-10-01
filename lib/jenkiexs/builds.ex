defmodule Jenkiexs.Builds do

  @type job_name() :: binary()

  alias Jenkiexs.Client
  alias Jenkiexs.Builds.{Build, Monitor}
  alias Jenkiexs.Jobs.Job

  defdelegate monitor(build), to: Monitor

  @spec details(Build.t()) :: {:ok, Build.t()} | {:error, binary()}
  def details(%Build{job_name: job_name, number: build_number}),
    do: details(job_name, build_number)

  @spec details(Job.t(), Build.t() | binary() | integer()) :: {:ok, Build.t()} | {:error, binary()}
  def details(%Job{name: job_name} = _job, %Build{number: build_number}),
    do: details(job_name, build_number)
  def details(%Job{name: job_name} = _job, build_number),
    do: details(job_name, build_number)

  @spec details(job_name(), build_number :: binary() | integer()) :: {:ok, Build.t()} | {:error, binary()}
  def details(job_name, build_number) do
    case Client.get!("/job/#{job_name}/#{build_number}/api/json") do
      %{status_code: 200, body: body} ->
        build = new(job_name, body)
        {:ok, build}
      response ->
        {:error, inspect(response)}
    end
  end

  @spec last(Job.t() | job_name())
    :: {:ok, Build.t()} | {:error, reason :: binary()}
  def last(%Job{name: job_name} = _job), do: last(job_name)
  def last(job_name) do
    case Client.get!("/job/#{job_name}/lastBuild/api/json") do
      %{status_code: 200, body: body} ->
        build = new(job_name, body)
        {:ok, build}
      response ->
        {:error, inspect(response)}
    end
  end

  @spec last!(Job.t() | job_name()) :: Build.t()
  def last!(%Job{name: job_name} = _job), do: last!(job_name)
  def last!(job_name) do
    case last(job_name) do
      {:ok, build} -> build
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Returns the job URL based on a given Build.

  ## Examples

      iex> Jenkiexs.Build.url(%Build{job_name: "example", number: 42})
      "http://localhost/job/example/42"

  """

  @spec url(Build.t()) :: String.t()
  def url(%Build{job_name: job, number: number} = _build) do
    base_url = Application.get_env(:jenkiexs, :client) |> Keyword.get(:url)
    "#{base_url}/job/#{job}/#{number}"
  end

  def new(job_name, jenkins_build) do
    %{
      "building" => building,
      "duration" => duration,
      "estimatedDuration" => estimated_duration,
      "number" => number,
      "result" => result,
      "timestamp" => timestamp
      } = jenkins_build

      parameters = jenkins_build
        |> Map.get("actions")
        |> Enum.filter(&(Map.has_key?(&1, "parameters")))
        |> Enum.flat_map(&(Map.get(&1, "parameters")))
        |> Enum.map(fn
          %{"name" => key, "value" => value} ->
            {String.to_atom(key), value}
          end)
        |> Map.new()

      %Build{
        job_name: job_name,
        number: number,
        building?: building,
        duration: duration,
        estimated_duration: estimated_duration,
        result: result,
        parameters: parameters,
        timestamp: timestamp
      }
  end

end
