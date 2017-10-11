defmodule PayWay.API.SettlementAccount do
  @moduledoc """
  List settlement accounts and their associated merchants and bank accounts.
  """

  @doc """
  List of merchants.
  """
  @spec list_merchants() :: list
  def list_merchants do
    PayWay.get("/merchants")["data"]
  end

  @doc """
  List of bank accounts.
  """
  @spec list_bank_accounts() :: list
  def list_bank_accounts do
    PayWay.get("/your-bank-accounts")["data"]
  end
end
