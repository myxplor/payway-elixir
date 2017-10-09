defmodule PayWay.PaymentMethod.CreditCard do
  @moduledoc """
  Credit card payment method for a customer.
  """

  defstruct paymentMethod: "CreditCard",
            cardNumber: nil,
            cardholderName: nil,
            cvn: nil,
            expiryDateMonth: nil,
            expiryDateYear: nil
end
