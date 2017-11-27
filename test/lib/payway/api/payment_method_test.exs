defmodule PayWay.API.PaymentMethodTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.{PaymentMethod, Token}
  alias PayWay.PaymentMethod.{CreditCard, BankAccount}

  @customer_number_pattern ~r/\d{5,}/

  doctest PaymentMethod

  test "adds a new customer payment method credit card" do
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

  test "adds a new customer payment method bank account" do
    use_cassette "add_customer_payment_method_bank_account" do
      resp = PaymentMethod.add(%BankAccount{
        bsb:           "000000",
        accountNumber: "111111",
        accountName:   "Xplor",
      }, "0000000A")

      assert String.match?(resp["customerNumber"], @customer_number_pattern)

      assert %{
        "paymentSetup" => %{
          "bankAccount" => %{"accountNumber" => "111111"}
        }
      } = PaymentMethod.get(resp["customerNumber"])
    end
  end

  test "updates an existing customer payment method credit card" do
    use_cassette "update_customer_payment_method_credit_card", match_requests_on: [:request_body] do
      ref = PaymentMethod.add(%CreditCard{
        cardNumber:      "4564710000000004",
        expiryDateMonth: "02",
        expiryDateYear:  "19",
        cvn:             "847",
        cardholderName:  "Xplor",
      }, "TEST")["customerNumber"]

      token = Token.get(%CreditCard{
        cardNumber:      "5163200000000008",
        expiryDateMonth: "08",
        expiryDateYear:  "20",
        cvn:             "070",
        cardholderName:  "Xplor",
      })

      resp = PaymentMethod.update(ref, token, "TEST")

      assert %{
        "paymentSetup" => %{
          "creditCard" => %{"cardNumber" => "516320...008"}
        }
      } = PaymentMethod.get(resp["customerNumber"])
    end
  end

  test "updates an existing customer payment method bank account" do
    use_cassette "update_customer_payment_method_bank_account", match_requests_on: [:request_body] do
      ref = PaymentMethod.add(%BankAccount{
        bsb:           "000000",
        accountNumber: "111111",
        accountName:   "Xplor",
      }, "0000000A")["customerNumber"]

      token = Token.get(%BankAccount{
        bsb:           "000000",
        accountNumber: "222222",
        accountName:   "Xplor",
      })

      resp = PaymentMethod.update(ref, token, "0000000A")

      assert %{
        "paymentSetup" => %{
          "bankAccount" => %{"accountNumber" => "222222"}
        }
      } = PaymentMethod.get(resp["customerNumber"])
    end
  end
end
