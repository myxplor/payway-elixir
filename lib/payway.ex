defmodule PayWay do
  @moduledoc """
  PayWay REST API Elixir wrapper.
  """

  alias PayWay.{Options, REST}

  @spec init(keyword) :: keyword
  def init(opts \\ []) do
    Options.assign_defaults(opts)
  end

  @spec get(binary, keyword) :: map
  def get(path, payway_opts) do
    resp = REST.get!(path, [], payway_opts: payway_opts)

    Poison.decode!(resp.body)
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
