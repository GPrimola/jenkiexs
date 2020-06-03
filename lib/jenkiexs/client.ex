defmodule Jenkiexs.Client do
  use HTTPoison.Base
  require Logger

  @impl true
  def process_request_url(endpoint \\ "/"), do: api_url() <> endpoint

  @impl true
  def process_request_headers(headers)
  def process_request_headers(headers) when is_list(headers) do
    process_request_headers(Map.new(headers))
  end
  def process_request_headers(headers) when is_map(headers) do
    default_headers()
    |> Map.merge(access_headers())
    |> Map.merge(headers)
    |> Map.to_list()
  end

  @impl true
  def process_request_params(params)
  def process_request_params(params) when is_list(params) do
    process_request_params(Map.new(params))
  end
  def process_request_params(params) when is_map(params) do
    default_params()
    |> Map.merge(params)
    |> Map.to_list()
  end

  @impl true
  def process_request_options(options)
  def process_request_options(options) when is_list(options) do
    process_request_options(Map.new(options))
  end
  def process_request_options(options) when is_map(options) do
    default_options()
    |> Map.merge(options)
    |> Map.to_list()
  end

  @impl true
  def process_response_body(body)
  def process_response_body("" = body), do: body
  def process_response_body(body) do
    Jason.decode!(body)
  rescue
    _ -> body
  end

  @spec default_headers() :: map()
  defp default_headers do
    %{
      "Content-Type" => "application/json",
      "Accept" => "application/json"
    }
  end

  @spec access_headers() :: map()
  defp access_headers do
    username = System.get_env("JENKINS_USERNAME") || Map.get(credentials(), :username)
    token = System.get_env("JENKINS_TOKEN") || Map.get(credentials(), :token)
    basic_auth = Base.encode64("#{username}:#{token}")
    auth_headers = %{"Authorization" => "Basic #{basic_auth}"}
    [crumb_header, crumb_number] =
      "#{api_url()}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)"
      |> HTTPoison.get!(auth_headers)
      |> Map.get(:body)
      |> String.split(":")

    Map.merge(auth_headers, %{crumb_header => crumb_number})
  end

  def access_token(), do: Map.get(credentials(), :token)

  @spec config() :: [config_key: any()]
  defp config, do: Application.get_env(:jenkiexs, :client)

  @spec api_url() :: binary()
  defp api_url, do: System.get_env("JENKINS_URL") || Keyword.get(config(), :url)

  @spec credentials() :: map()
  defp credentials do
    Keyword.take(config(), [:username, :token])
    |> Map.new()
  end

  @spec ssl_options() :: list()
  defp ssl_options do
    [
      versions: [:"tlsv1.2"]
    ]
  end

  @spec default_params() :: map()
  defp default_params, do: %{}

  @spec default_options() :: map()
  defp default_options, do: %{ssl: ssl_options()}
end
