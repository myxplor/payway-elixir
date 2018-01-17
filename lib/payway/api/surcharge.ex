defmodule PayWay.API.Surcharge do
  @moduledoc """
  Surcharge handling.
  """

  @doc """
  Gets the surcharge rates.
  """
  @spec get() :: map
  def get() do
    PayWay.get("/surcharges")
  end
end
