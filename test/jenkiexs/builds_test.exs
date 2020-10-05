defmodule Jenkiexs.BuildsTest do
  use ExUnit.Case

  alias Jenkiexs.{Builds, Builds.Build}

  describe "url/1" do
    test "should return the given job url" do
      base_url = Application.get_env(:jenkiexs, :client)[:url]
      build = %Build{job_name: "example", number: "42"}

      assert "#{base_url}/job/example/42" == Builds.url(build)
    end

    test "should return an empty job url when an empty build is given" do
      base_url = Application.get_env(:jenkiexs, :client)[:url]
      assert "#{base_url}/job//" == Builds.url(%Build{})
    end
  end

  describe "last/1" do
    test "should return last build of the given job" do
      job_name = "success_job"
      assert {:ok, build} = Builds.last(job_name)
    end

    test "should return error when job doesn't exist" do
      job_name = "not_found_job"
      assert {:error, "Got status 404 with body \"\"."} = Builds.last(job_name)
    end

    test "should return error when something is wrong" do
      job_name = "broken job"

      assert {:error, "Got status 500 with body \"something went wrong\"."} =
               Builds.last(job_name)
    end
  end
end
