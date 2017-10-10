defmodule PayWay.PaymentMethod.CreditCard do
  @moduledoc """
  Credit card payment method for a customer.
  """

  defstruct paymentMethod: "creditCard",
            cardNumber: nil,
            cardholderName: nil,
            cvn: nil,
            expiryDateMonth: nil,
            expiryDateYear: nil
end
