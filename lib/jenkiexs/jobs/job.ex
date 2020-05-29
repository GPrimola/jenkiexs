defmodule Jenkiexs.Jobs.Job do
  defstruct [
    :name,
    :path,
    :full_name,
    :display_name,
    :full_display_name,
    :in_queue?,
    :disabled?,
    :buildable?,
    :description,
    :build_parameters,
    :next_build_number,
    :last_build_number
  ]

  @jenkins_job_attrs ~w(
      name
      description
      fullName
      displayName
      fullDisplayName
      inQueue
      buildable
      disabled
      nextBuildNumber
      property
      builds
    )
  @jenkins_job_property_attrs ~w(parameterDefinitions)
  @jenkins_job_property_paramenter_definitions_attrs ~w(
      name
      defaultParameterValue
    )
  @jenkins_job_property_paramenter_definitions_default_parameter_attrs ~w(value)

  def jenkins_job_attrs, do: @jenkins_job_attrs
  def jenkins_job_property_attrs, do: @jenkins_job_property_attrs
  def jenkins_job_property_paramenter_definitions_attrs,
    do: @jenkins_job_property_paramenter_definitions_attrs
  def jenkins_job_property_paramenter_definitions_default_parameter_attrs,
    do: @jenkins_job_property_paramenter_definitions_default_parameter_attrs

end
