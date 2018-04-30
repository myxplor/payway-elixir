defmodule PayWay.API.SettlementAccount do
  @moduledoc """
  List settlement accounts and their associated merchants and bank accounts.
  """

  @doc """
  List of merchants.
  """
  @spec list_merchants(keyword) :: list
  def list_merchants(payway_opts) do
    PayWay.get("/merchants", payway_opts)["data"]
  end

  @doc """
  List of bank accounts.
  """
  @spec list_bank_accounts(keyword) :: list
  def list_bank_accounts(payway_opts) do
    PayWay.get("/your-bank-accounts", payway_opts)["data"]
  end
end
