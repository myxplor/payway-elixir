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
  @spec get(String.t, keyword) :: map
  def get(ref, payway_opts) do
    PayWay.get("/customers/" <> ref, payway_opts)
  end

  @doc """
  Adds and stores a user's payment method in PayWay.

  A PayWay receivable account (either a merchant ID or a bank account ID) needs
  to be specified. According to Westpac, the receivable account is not enforced
  and therefore can be overwritten at the time of payment.
  """
  @spec add(payment_method, String.t, keyword) :: map
  def add(payment_method, receivable_account, payway_opts) do
    payment_method
    |> Token.get(payway_opts)
    |> save(receivable_account, payway_opts)
  end

  @doc """
  Stores a payment method in PayWay by supplying a single use token.
  """
  @spec save(String.t, String.t, keyword) :: map
  def save(token, receivable_account, payway_opts) do
    PayWay.post(
      "/customers",
      %{
        singleUseTokenId: token,
        merchantId:       receivable_account,
        bankAccountId:    receivable_account,
      },
      payway_opts
    )
  end

  @doc """
  Updates a stored payment method in PayWay by supplying a single use token.

  `payment_method_ref` is PayWay's customerNumber.
  """
  @spec update(String.t, String.t, String.t, keyword) :: map
  def update(payment_method_ref, token, receivable_account, payway_opts) do
    PayWay.put(
      "/customers/" <> payment_method_ref <> "",
      %{
        singleUseTokenId: token,
        merchantId:       receivable_account,
        bankAccountId:    receivable_account,
      },
      payway_opts
    )
  end
end
