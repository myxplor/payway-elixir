defmodule PayWay do
  @moduledoc """
  PayWay REST API Elixir wrapper.
  """

  alias PayWay.{Options, REST}
  alias NimbleCSV.RFC4180, as: CSV

  @spec init(keyword) :: keyword
  def init(opts \\ []) do
    Options.assign_defaults(opts)
  end

  @spec get(binary, keyword) :: map
  def get(path, payway_opts) do
    resp = REST.get!(path, [], payway_opts: payway_opts)

    Poison.decode!(resp.body)
  end

  @spec get_csv(binary, keyword) :: list
  def get_csv(path, payway_opts) do
    %HTTPoison.Response{body: body} = REST.get!(path, [], payway_opts: payway_opts)
    data = CSV.parse_string(body, skip_headers: false)

    header = hd(data)
    receipts = tl(data)

    Enum.map(receipts, fn receipt -> 
      Enum.zip(header, receipt)
      |> Enum.into(%{})
    end)
  end

  @spec post(binary, map, keyword) :: map
  def post(path, body, payway_opts) do
    resp = REST.post!(path, body, [], payway_opts: payway_opts)

    Poison.decode!(resp.body)
  end

  @spec put(binary, map, keyword) :: map
  def put(path, body, payway_opts) do
    resp = REST.put!(path, body, [], payway_opts: payway_opts)

    Poison.decode!(resp.body)
  end
end
