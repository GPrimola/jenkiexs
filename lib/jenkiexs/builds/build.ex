defmodule Jenkiexs.Jobs.Build do
  defstruct [
    :job_name,
    :number,
    :parameters,
    :building?,
    :duration,
    :estimated_duration,
    :result,
    :timestamp
  ]

  @jenkins_build_attrs ~w(
    number
    actions
    building
    duration
    estimatedDuration
    result
    timestamp
    )
  @jenkins_build_actions_attrs ~w(parameters)
  @jenkins_build_actions_paramenters_attrs ~w(name value)

  def jenkins_build_attrs, do: @jenkins_build_attrs
  def jenkins_build_actions_attrs, do: @jenkins_build_actions_attrs
  def jenkins_build_actions_paramenters_attrs,
    do: @jenkins_build_actions_paramenters_attrs
end
