defmodule Jenkiexs do
  @moduledoc """
  Provide functions to interact with a Jenkins server.
  """

  @doc """
  Starts a job with the given parameters.

  ## Examples

      iex> Jenkiexs.Jobs.build("my-job")
      {:ok, %Jenkiexs.Builds.Build{}}

      iex> Jenkiexs.Jobs.build("my-job", param1: "foo", param2: "bar")
      {:ok, %Jenkiexs.Builds.Build{}}

      iex> Jenkiexs.Jobs.build("my-job")
      {:error, "reason"}
  """
  defdelegate build(job, params), to: Jenkiexs.Jobs

  @doc """
  Starts a job with no parameter.
  """
  defdelegate build(job), to: Jenkiexs.Jobs

  @doc """
  Starts a job and returns a task that monitor its execution.

  ## Examples

      iex> Jenkiexs.Jobs.build_monitored("my-job")
      {:ok, %Task{pid: 1, ref: 2, owner: 3}}

      iex> Jenkiexs.Jobs.build_monitored("my-job", param1: "foo", param2: "bar")
      {:ok, %Task{pid: 1, ref: 2, owner: 3}}

      iex> Jenkiexs.Jobs.build_monitored("my-job", param1: "foo", param2: "bar")
      {:error, "reason"}
  """
  defdelegate build_monitored(job, params), to: Jenkiexs.Jobs

  @doc """
  Starts a job with no parameter and returns a task that monitor the job for completeness.
  """
  defdelegate build_monitored(job), to: Jenkiexs.Jobs

  @doc """
  Returns the last build of a given job.
  """
  defdelegate last_build(job), to: Jenkiexs.Builds, as: :last
end
