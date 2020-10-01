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
end
