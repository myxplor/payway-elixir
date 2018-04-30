defmodule PayWay.API.Surcharge do
  @moduledoc """
  Surcharge handling.
  """

  @doc """
  Gets the surcharge rates.
  """
  @spec get(keyword) :: map
  def get(payway_opts) do
    PayWay.get("/surcharges", payway_opts)
  end
end
