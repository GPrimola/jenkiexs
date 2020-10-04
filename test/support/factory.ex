defmodule Jenkiexs.Factory do
  use ExMachina

  def job_factory do
    %{
      "name" => sequence("name", &"Job #{&1}"),
      "description" => "Job description",
      "fullName" => sequence("fullName", &"Full Name Job #{&1}"),
      "displayName" => sequence("displayName", &"Display Name Job #{&1}"),
      "fullDisplayName" => sequence("fullDisplayName", &"Full Name Job #{&1}"),
      "inQueue" => false,
      "buildable" => true,
      "disabled" => false,
      "nextBuildNumber" => sequence("nextBuildNumber", &(&1)),
      "property" => build(:job_property),
      "builds" => build_list(5, :build),
    }
  end

  def job_property_factory do
    %{
      "parameterDefinitions" =>
        build_list(5, :job_property_parameter_definitions)
    }
  end

  def job_property_parameter_definitions_factory do
    %{
      "name" => sequence("name", &"Parameter #{&1}"),
      "defaultParameterValue" => %{
        "value" => sequence("value", &"Value #{&1}")
      }
    }
  end

  def build_factory do
    %{
      "number" => sequence("number", &(&1)),
      "actions" => build_list(5, :build_action),
      "building" => false,
      "duration" => 1234,
      "estimatedDuration" => 1234,
      "result" => "SUCCESS",
      "timestamp" => NaiveDateTime.utc_now(),
    }
  end

  def build_action_factory do
    %{
      "parameters" => build_list(5, :build_action_parameter)
    }
  end

  def build_action_parameter_factory do
    %{
      "name" => sequence("name", &"Parameter #{&1}"),
      "value" => sequence("value", &"Value #{&1}")
    }
  end
end
