defmodule PayWay.API.Transaction do
  @moduledoc """
  Transaction handling.
  """

  alias PayWay.Utils
  alias PayWay.API.PaymentMethod
  alias PayWay.PaymentMethod.{CreditCard, BankAccount}

  @doc """
  Makes a new payment transaction.

  The first argument can be either a payment struct, or a string representing
  the `payment_method_ref` (see below). Passing in a payment struct is useful
  for one-time payments where payment information do not need to be stored.

  `payment_method_ref` is the "customerNumber" in PayWay, it is effectively a
  customer's payment method (either a credit card or a bank account) used for
  the transaction.

  We are sending the `receivable_account` as both "merchantId" and
  "bankAccountId" so that we don't have to look up what payment method the
  `payment_method_ref` is, and PayWay ignores the field when the payment
  method mismatches.
  """
  @spec make_payment(map | PaymentMethod.payment_method | String.t, String.t, number, String.t) :: map
  def make_payment(payment_method, receivable_account, principle_amount, order_number \\ "")

  def make_payment(%{"cardNumber" => _} = attrs, receivable_account, principle_amount, order_number) do
    Kernel.struct(%CreditCard{}, Utils.atomify_map(attrs))
    |> make_payment(receivable_account, principle_amount, order_number)
  end

  def make_payment(%{"accountNumber" => _} = attrs, receivable_account, principle_amount, order_number) do
    Kernel.struct(%BankAccount{}, Utils.atomify_map(attrs))
    |> make_payment(receivable_account, principle_amount, order_number)
  end

  def make_payment(payment_method, receivable_account, principle_amount, order_number) do
    PayWay.post(
      "/transactions",
      %{
        "transactionType" => "payment",
        "currency"        => "aud",
        "customerNumber"  => get_payment_method_ref(payment_method, receivable_account),
        "principalAmount" => principle_amount,
        "orderNumber"     => order_number,
        "merchantId"      => receivable_account,
        "bankAccountId"   => receivable_account,
      }
    )
  end

  defp get_payment_method_ref(payment_method, _receivable_account)
    when is_binary(payment_method), do: payment_method

  defp get_payment_method_ref(payment_method, receivable_account) do
    PaymentMethod.add(payment_method, receivable_account)["customerNumber"]
  end

  @doc """
  Gets the surcharge amount from the payment method and principle amount.
  """
  @spec get_surcharge(String.t, number) :: number
  def get_surcharge(payment_method_ref, principle_amount) do
    PayWay.get(
      "/customers/#{payment_method_ref}/surcharge?principalAmount=#{principle_amount}"
    )["surchargeAmount"]
  end
end
