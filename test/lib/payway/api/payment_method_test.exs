defmodule PayWay.API.PaymentMethodTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.PaymentMethod
  alias PayWay.PaymentMethod.CreditCard

  @customer_number_pattern ~r/\d{5,}/

  doctest PaymentMethod

  test "add a new customer payment method" do
    use_cassette "add_customer_payment_method" do
      resp = PaymentMethod.add(%CreditCard{
        cardNumber:      "4564710000000004",
        expiryDateMonth: "02",
        expiryDateYear:  "19",
        cvn:             "847",
        cardholderName:  "Xplor",
      }, "TEST")

      assert String.match?(resp["customerNumber"], @customer_number_pattern)
    end
  end
end
