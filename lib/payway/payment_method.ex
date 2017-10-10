defmodule PayWay.PaymentMethod do
  @moduledoc """
  Customer's payment method handling.
  """

  alias PayWay.Token
  alias PayWay.PaymentMethod.{CreditCard, BankAccount}

  @type payment_method :: %CreditCard{} | %BankAccount{}

  @spec add(payment_method, String.t) :: map
  def add(payment_method, receivable_account) do
    payment_method
    |> Token.get
    |> create_new_payway_customer(receivable_account)
  end

  defp create_new_payway_customer(token, receivable_account) do
    PayWay.post(
      "/customers",
      %{
        singleUseTokenId: token,
        merchantId:       receivable_account,
      }
    )
  end
end
