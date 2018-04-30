defmodule PayWay.API.PaymentMethodTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.{PaymentMethod, Token}
  alias PayWay.PaymentMethod.{CreditCard, BankAccount}

  @customer_number_pattern ~r/\d{5,}/

  doctest PaymentMethod

  test "adds a new customer payment method credit card", %{payway_opts: payway_opts} do
    use_cassette "add_customer_payment_method_credit_card" do
      resp = PaymentMethod.add(%CreditCard{
        cardNumber:      "4564710000000004",
        expiryDateMonth: "02",
        expiryDateYear:  "19",
        cvn:             "847",
        cardholderName:  "Xplor",
      }, "TEST", payway_opts)

      assert String.match?(resp["customerNumber"], @customer_number_pattern)

      assert %{
        "paymentSetup" => %{
          "creditCard" => %{"cardNumber" => "456471...004"}
        }
      } = PaymentMethod.get(resp["customerNumber"], payway_opts)
    end
  end

  test "adds a new customer payment method bank account", %{payway_opts: payway_opts} do
    use_cassette "add_customer_payment_method_bank_account" do
      resp = PaymentMethod.add(%BankAccount{
        bsb:           "000000",
        accountNumber: "111111",
        accountName:   "Xplor",
      }, "0000000A", payway_opts)

      assert String.match?(resp["customerNumber"], @customer_number_pattern)

      assert %{
        "paymentSetup" => %{
          "bankAccount" => %{"accountNumber" => "111111"}
        }
      } = PaymentMethod.get(resp["customerNumber"], payway_opts)
    end
  end

  test "updates an existing customer payment method credit card", %{payway_opts: payway_opts} do
    use_cassette "update_customer_payment_method_credit_card", match_requests_on: [:request_body] do
      ref = PaymentMethod.add(%CreditCard{
        cardNumber:      "4564710000000004",
        expiryDateMonth: "02",
        expiryDateYear:  "19",
        cvn:             "847",
        cardholderName:  "Xplor",
      }, "TEST", payway_opts)["customerNumber"]

      token = Token.get(%CreditCard{
        cardNumber:      "5163200000000008",
        expiryDateMonth: "08",
        expiryDateYear:  "20",
        cvn:             "070",
        cardholderName:  "Xplor",
      }, payway_opts)

      resp = PaymentMethod.update(ref, token, "TEST", payway_opts)

      assert %{
        "paymentSetup" => %{
          "creditCard" => %{"cardNumber" => "516320...008"}
        }
      } = PaymentMethod.get(resp["customerNumber"], payway_opts)
    end
  end

  test "updates an existing customer payment method bank account", %{payway_opts: payway_opts} do
    use_cassette "update_customer_payment_method_bank_account", match_requests_on: [:request_body] do
      ref = PaymentMethod.add(%BankAccount{
        bsb:           "000000",
        accountNumber: "111111",
        accountName:   "Xplor",
      }, "0000000A", payway_opts)["customerNumber"]

      token = Token.get(%BankAccount{
        bsb:           "000000",
        accountNumber: "222222",
        accountName:   "Xplor",
      }, payway_opts)

      resp = PaymentMethod.update(ref, token, "0000000A", payway_opts)

      assert %{
        "paymentSetup" => %{
          "bankAccount" => %{"accountNumber" => "222222"}
        }
      } = PaymentMethod.get(resp["customerNumber"], payway_opts)
    end
  end
end
