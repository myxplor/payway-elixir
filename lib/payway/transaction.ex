defmodule PayWay.Transaction do
  @moduledoc """
  Transaction handling.
  """

  @doc """
  Makes a new payment transaction.

  `payment_method_ref` is the "customerNumber" in PayWay, it is effectively a
  customer's payment method (either a credit card or a bank account) used for
  the transaction.

  We are sending the `receivable_account` as both "merchantId" and
  "bankAccountId" so that we don't have to look up what payment method the
  `payment_method_ref` is, and PayWay ignores the field when the payment
  method mismatches.
  """
  @spec make_payment(String.t, String.t, number, String.t) :: map
  def make_payment(
    payment_method_ref, receivable_account, amount, order_number \\ ""
  ) do
    PayWay.post(
      "/transactions",
      %{
        "transactionType" => "payment",
        "currency"        => "aud",
        "customerNumber"  => payment_method_ref,
        "principalAmount" => amount,
        "orderNumber"     => order_number,
        "merchantId"      => receivable_account,
        "bankAccountId"   => receivable_account,
      }
    )
  end
end
