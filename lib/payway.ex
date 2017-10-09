defmodule PayWay do
  @moduledoc """
  PayWay REST API Elixir wrapper.
  """

  alias PayWay.{Options, REST}

  @spec init(opts :: keyword) :: {:ok, pid}
  def init(opts \\ []) do
    opts
    |> Options.assign_defaults
    |> Options.store
  end

  @spec get(path :: String.t) :: map
  def get(path) do
    resp = REST.get!(path)

    Poison.decode!(resp.body)
  end
end
