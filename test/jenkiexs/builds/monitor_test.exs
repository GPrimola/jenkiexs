defmodule Jenkiexs.Builds.MonitorTest do
  use ExUnit.Case, async: true

  alias Jenkiexs.Builds.{Build, Monitor}

  describe "monitor/1" do
    test "should return tuple {:ok, task} when a build is given" do
      build = %Build{job_name: "success_job", number: 42}
      assert {:ok, task} = Monitor.monitor(build)
    end

    test "should return a task alive when build is building" do
      build = %Build{job_name: "success_job", number: 42}
      assert {:ok, task} = Monitor.monitor(build)
      assert %Task{} = task
      assert Process.alive?(task.pid)
    end

    test "should return a dead task when build is not building" do
      build = %Build{job_name: "success_job", number: -1}
      assert {:ok, task} = Monitor.monitor(build)
      assert %Task{} = task
      Task.await(task)
      refute Process.alive?(task.pid)
    end

    test "should return a finished build after Task.await/1" do
      build = %Build{job_name: "success_job", number: -1}
      assert {:ok, task} = Monitor.monitor(build)
      assert %Task{} = task
      assert {:ok, build} = Task.await(task)
      assert %Build{building?: false, job_name: "success_job", number: -1} = build
    end
  end
end
