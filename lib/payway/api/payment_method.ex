defmodule PayWay.API.PaymentMethod do
  @moduledoc """
  Customer's payment method handling.
  """

  alias PayWay.API.Token
  alias PayWay.PaymentMethod.{CreditCard, BankAccount}

  @type payment_method :: %CreditCard{} | %BankAccount{}

  @doc """
  Gets a payment method based on its reference (customerNumber).
  """
  @spec get(String.t) :: map
  def get(ref) do
    PayWay.get("/customers/" <> ref)["paymentSetup"]
  end

  @doc """
  Adds and stores a user's payment method in PayWay.

  A PayWay receivable account (either a merchant ID or a bank account ID) needs
  to be specified. According to Westpac, the receivable account is not enforced
  and therefore can be overwritten at the time of payment.
  """
  @spec add(payment_method, String.t) :: map
  def add(payment_method, receivable_account) do
    payment_method
    |> Token.get()
    |> save(receivable_account)
  end

  @doc """
  Stores a payment method in PayWay by supplying a single use token.
  """
  @spec add(String.t, String.t) :: map
  def save(token, receivable_account) do
    PayWay.post(
      "/customers",
      %{
        singleUseTokenId: token,
        merchantId:       receivable_account,
        bankAccountId:    receivable_account,
      }
    )
  end
end
