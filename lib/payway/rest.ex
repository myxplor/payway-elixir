defmodule PayWay.REST do
  @moduledoc """
  HTTP library for making PayWay REST API calls.

  Functions here all require an API key (either secret or publishable) to work.
  """

  alias PayWay.Options

  use HTTPoison.Base

  def process_url(path) do
    api_endpoint() <> path
  end

  def process_request_headers(headers) do
    headers ++ [{"Accept", "application/json"}]
  end

  def process_request_options(options) do
    options ++ [hackney: [basic_auth: {api_key(), ""}]]
  end

  defp api_endpoint, do: Options.retrieve(:api_endpoint)
  defp api_key,      do: Options.retrieve(:api_key)
end
