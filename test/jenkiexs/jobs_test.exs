defmodule Jenkiexs.JobsTest do
  use ExUnit.Case

  alias Jenkiexs.{Jobs, Jobs.Job, Builds.Build}

  describe "all/0" do
    test "should return a list of all jobs" do
      assert {:ok, jobs} = Jobs.all()
      assert is_list(jobs)
      assert length(jobs) == 5
    end
  end

  describe "all!/0" do
    test "should return a list of all jobs" do
      assert jobs = Jobs.all!()
      assert is_list(jobs)
      assert length(jobs) == 5
    end
  end

  describe "url/1" do
    test "should return the given job url" do
      base_url = Application.get_env(:jenkiexs, :client)[:url]
      job = %Job{name: "example"}

      assert "#{base_url}/job/example" == Jobs.url(job)
    end

    test "should return the job url when a binary is given" do
      base_url = Application.get_env(:jenkiexs, :client)[:url]
      assert "#{base_url}/job/example" == Jobs.url("example")
    end
  end

  describe "details/1" do
    test "should return the job details for a given job" do
      job = %Job{name: "success_job"}
      assert {:ok, %Job{}} = Jobs.details(job)
    end
  end

  describe "build/2" do
    test "should start a build of the given job" do
      assert {:ok, build} = Jobs.build("success_job")
      assert %Build{} = build
    end

    test "should start a build of the given job with parameters" do
      assert {:ok, build} = Jobs.build("success_job", param: 1)
      assert %Build{} = build
    end

    test "should return error with reason when job doesn't exist" do
      assert {:error, reason} = Jobs.build("not_found_job")
      assert "Got status 404 with body \"\"." == reason
    end
  end

  describe "build!/2" do
    test "should start a build of the given job" do
      assert %Build{} = Jobs.build!("success_job")
    end

    test "should start a build of the given job with parameters" do
      assert %Build{} = Jobs.build!("success_job", param: 1)
    end

    test "should return error with reason when job doesn't exist" do
      assert_raise RuntimeError, "Got status 404 with body \"\".", fn ->
        Jobs.build!("not_found_job")
      end
    end
  end

  describe "build_monitored/2" do
    test "should return tuple {:ok, task} when job can be built" do
      job = %Job{name: "success_job"}
      assert {:ok, task} = Jobs.build_monitored(job)
      assert %Task{} = task
    end

    test "should return tuple {:error, reason} when job cannot be built" do
      job = %Job{name: "not_buildable_job"}
      assert {:error, reason} = Jobs.build_monitored(job)

      assert match?(
               "Could not build job not_buildable_job. Received status 400 with body: Not valid request",
               reason
             )
    end

    test "should return tuple {:ok, task} when job can be built with params" do
      job = %Job{name: "success_job"}
      params = [{"param1", "value"}]
      assert {:ok, task} = Jobs.build_monitored(job, params)
      assert %Task{} = task
    end
  end
end
