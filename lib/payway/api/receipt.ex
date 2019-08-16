defmodule PayWay.API.Receipt do
  @moduledoc """
  Daily receipt files that contain transaction details. 
  """

  @doc """
  Lists all receipts.
  """
  @spec list(keyword) :: map
  def list(payway_opts) do
    PayWay.get("/receipts-files", payway_opts)
  end

  @doc """
  Downloads the receipt file for a given date.
  """
  @spec download(String.t, String.t, String.t, keyword) :: list
  def download(yyyy, mm, dd, payway_opts) do
    PayWay.get_csv("/receipts-files/#{yyyy}-#{mm}-#{dd}/csv-report", payway_opts)
  end
end
