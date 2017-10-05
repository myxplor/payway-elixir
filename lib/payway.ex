defmodule PayWay do
  @moduledoc """
  PayWay REST API Elixir wrapper.
  """

  alias PayWay.{Options, REST}

  def init(opts \\ []) do
    opts
    |> Options.assign_defaults
    |> Options.store
  end

  def get(path) do
    with {:ok, resp} <- REST.get(path) do
      Poison.decode!(resp.body)
    end
  end
end
