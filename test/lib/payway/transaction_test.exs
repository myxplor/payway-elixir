defmodule PayWay.TransactionTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.{Transaction, PaymentMethod, PaymentMethod.CreditCard}

  doctest Transaction

  test "make payment" do
    use_cassette "transaction_make_payment" do
      resp = Transaction.make_payment(
        payment_method_ref(), "TEST", 1337.42, "XPLOR_SCHOOLS_007"
      )

      assert resp["orderNumber"]     == "XPLOR_SCHOOLS_007"
      assert resp["principalAmount"] == 1337.42
      assert resp["surchargeAmount"] == 13.37
      assert resp["paymentAmount"]   == 1350.79
    end
  end

  test "lookup surcharge amount" do
    use_cassette "transaction_lookup_surcharge_amount" do
      assert Transaction.surcharge_for(
        payment_method_ref(), 1337.42
      ) == 13.37
    end
  end

  def payment_method_ref do
    PaymentMethod.add(%CreditCard{
      cardNumber:      "4564710000000004",
      expiryDateMonth: "02",
      expiryDateYear:  "19",
      cvn:             "847",
      cardholderName:  "Xplor",
    }, "TEST")["customerNumber"]
  end
end
