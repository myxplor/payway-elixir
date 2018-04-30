defmodule PayWay.REST do
  @moduledoc """
  HTTP library for making PayWay REST API calls.

  Functions here all require an API key (either secret or publishable) to work.
  """

  alias PayWay.Utils

  use HTTPoison.Base

  @recv_timeout 10_000

  def process_request_headers(headers) do
    [{"Accept", "application/json"}] ++ headers
  end

  def process_request_options(options) do
    Keyword.merge(
      [hackney: [basic_auth: {options[:payway_opts][:secret_key], ""}], recv_timeout: @recv_timeout],
      options
    )
  end

  def get!(url, headers \\ [], options \\ []) do
    url = payway_url(url, options[:payway_opts])

    super(url, headers, options)
  end

  def post!(url, body, headers \\ [], options \\ []) do
    url  = payway_url(url, options[:payway_opts])
    body = URI.encode_query(body)

    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Idempotency-Key", Utils.uuid(url, body <> timestamp())}
    ] ++ headers

    super(url, body, headers, options)
  end

  def put!(url, body, headers \\ [], options \\ []) do
    url  = payway_url(url, options[:payway_opts])
    body = URI.encode_query(body)

    headers = [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Idempotency-Key", Utils.uuid(url, body <> timestamp())}
    ] ++ headers

    super(url, body, headers, options)
  end

  defp payway_url(url, payway_opts), do: payway_opts[:api_endpoint] <> url
  defp timestamp,                    do: :os.system_time() |> Integer.to_string()
end
