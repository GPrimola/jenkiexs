defmodule Jenkiexs do

  defdelegate build(job, params), to: Jenkiexs.Jobs
  defdelegate build(job), to: Jenkiexs.Jobs
  defdelegate build_monitored(job, params), to: Jenkiexs.Jobs
  defdelegate build_monitored(job), to: Jenkiexs.Jobs
  defdelegate last_build(job), to: Jenkiexs.Builds, as: :last

end
