defmodule Jenkiexs.Builds.Monitor do
  alias Jenkiexs.Builds
  alias Jenkiexs.Builds.Build

  @queue_time 2_000
  @after_build_duration_time 1_000

  @doc """
  Monitors when a running build ends.

  Returns a task that yields a build when complete.

  ## Examples

    iex> Jenkiexs.Builds.Monitor.monitor(%Build{})
    {:ok, task}

    iex> Jenkiexs.Builds.Monitor.monitor(%Build{})
    {:ok, Build.t()}
  """

  @spec monitor(Build.t()) :: {:ok, Task.t()}
  def monitor(%Build{estimated_duration: duration} = build) when not is_number(duration),
    do: monitor(%{build | estimated_duration: 0})

  def monitor(%Build{estimated_duration: duration} = build) do
    task =
      Task.async(fn ->
        check(build, duration + @queue_time)
      end)

    {:ok, task}
  end

  defp check(build, timeout) do
    Process.sleep(timeout)

    case Builds.details(build) do
      {:ok, %{building?: false} = completed_build} ->
        {:ok, completed_build}

      _ ->
        check(build, @after_build_duration_time)
    end
  end
end
