defmodule PayWay.PaymentMethod.BankAccount do
  @moduledoc """
  Bank account payment method for a customer.
  """

  defstruct paymentMethod: "BankAccount",
            bsb: nil,
            accountNumber: nil,
            accountName: nil
end
