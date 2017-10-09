defmodule PayWay do
  @moduledoc """
  PayWay REST API Elixir wrapper.
  """

  alias PayWay.{Options, REST, Token}

  def init(opts \\ []) do
    opts
    |> Options.assign_defaults
    |> Options.store
  end

  def get(path) do
    resp = REST.get!(path)

    Poison.decode!(resp.body)
  end
end
