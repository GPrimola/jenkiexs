defmodule Jenkiexs.JobsTest do
  use ExUnit.Case

  alias Jenkiexs.{Jobs, Jobs.Job}

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
end
