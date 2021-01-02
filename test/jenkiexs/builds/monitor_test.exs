defmodule Jenkiexs.Builds.MonitorTest do
  use ExUnit.Case, async: true

  alias Jenkiexs.Builds.{Build, Monitor}

  describe "monitor/1" do
    test "should return tuple {:ok, task} when a build is given" do
      build = %Build{job_name: "Test"}
      assert {:ok, task} = Monitor.monitor(build)
      assert %Task{} = task
    end

    test "should return a task alive when build is building" do
      build = %Build{job_name: "Test", building?: true}
      assert {:ok, task} = Monitor.monitor(build)
      assert %Task{} = task
      assert Process.alive?(task.pid)
    end
  end
end
