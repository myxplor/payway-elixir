defmodule PayWay.API.PaymentMethodTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.PaymentMethod
  alias PayWay.PaymentMethod.{CreditCard, BankAccount}

  @customer_number_pattern ~r/\d{5,}/

  doctest PaymentMethod

  test "add a new customer payment method credit card" do
    use_cassette "add_customer_payment_method_credit_card" do
      resp = PaymentMethod.add(%CreditCard{
        cardNumber:      "4564710000000004",
        expiryDateMonth: "02",
        expiryDateYear:  "19",
        cvn:             "847",
        cardholderName:  "Xplor",
      }, "TEST")

      assert String.match?(resp["customerNumber"], @customer_number_pattern)

      assert %{
        "paymentSetup" => %{
          "creditCard" => %{"cardNumber" => "456471...004"}
        }
      } = PaymentMethod.get(resp["customerNumber"])
    end
  end

  test "add a new customer payment method bank account" do
    use_cassette "add_customer_payment_method_bank_account" do
      resp = PaymentMethod.add(%BankAccount{
        bsb:           "000000",
        accountNumber: "111111",
        accountName:   "Xplor"
      }, "0000000A")

      assert String.match?(resp["customerNumber"], @customer_number_pattern)

      assert %{
        "paymentSetup" => %{
          "bankAccount" => %{"accountNumber" => "111111"}
        }
      } = PaymentMethod.get(resp["customerNumber"])
    end
  end
end
