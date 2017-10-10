defmodule PayWay.PaymentMethod.BankAccount do
  @moduledoc """
  Bank account payment method for a customer.
  """

  defstruct paymentMethod: "bankAccount",
            bsb: nil,
            accountNumber: nil,
            accountName: nil
end
