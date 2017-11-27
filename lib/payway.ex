defmodule PayWay do
  @moduledoc """
  PayWay REST API Elixir wrapper.
  """

  alias PayWay.{Options, REST}

  @spec init(keyword) :: {:ok, pid}
  def init(opts \\ []) do
    opts
    |> Options.assign_defaults
    |> Options.store
  end

  @spec get(binary) :: map
  def get(path) do
    resp = REST.get!(path)

    Poison.decode!(resp.body)
  end

  @spec post(binary, map) :: map
  def post(path, body) do
    resp = REST.post!(path, body)

    Poison.decode!(resp.body)
  end

  @spec put(binary, map) :: map
  def put(path, body) do
    resp = REST.put!(path, body)

    Poison.decode!(resp.body)
  end
end
