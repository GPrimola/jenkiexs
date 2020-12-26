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
end
