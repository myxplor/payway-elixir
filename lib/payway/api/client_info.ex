defmodule PayWay.API.ClientInfo do
  @moduledoc """
  Client information.
  """

  @doc """
  Gets the client info.
  """
  @spec get(keyword) :: map
  def get(payway_opts) do
    PayWay.get("/", payway_opts)
  end
end
