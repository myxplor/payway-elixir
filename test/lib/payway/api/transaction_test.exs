defmodule PayWay.API.TransactionTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.{Transaction, PaymentMethod}
  alias PayWay.PaymentMethod.CreditCard

  @transaction_id_pattern ~r/\d{10}/

  doctest Transaction

  test "makes payment" do
    use_cassette "transaction_make_payment" do
      resp = Transaction.make_payment(
        payment_method_ref(), "TEST", 1337.42, "XPLOR_SCHOOLS_007"
      )

      transaction_id = Integer.to_string(resp["transactionId"])

      assert String.match?(transaction_id, @transaction_id_pattern)

      assert resp["orderNumber"]     == "XPLOR_SCHOOLS_007"
      assert resp["principalAmount"] == 1337.42
      assert resp["surchargeAmount"] == 13.37
      assert resp["paymentAmount"]   == 1350.79
    end
  end

  test "makes one time payment" do
    use_cassette "transaction_make_one_time_payment" do
      resp = Transaction.make_payment(
        payment_method(), "TEST", 1337.42, "XPLOR_SCHOOLS_007"
      )

      transaction_id = Integer.to_string(resp["transactionId"])

      assert String.match?(transaction_id, @transaction_id_pattern)

      assert resp["orderNumber"]     == "XPLOR_SCHOOLS_007"
      assert resp["principalAmount"] == 1337.42
      assert resp["surchargeAmount"] == 13.37
      assert resp["paymentAmount"]   == 1350.79
    end
  end

  test "converts credit card map to struct" do
    use_cassette "transaction_make_one_time_payment_from_cc_map" do
      resp = Transaction.make_payment(
        %{
          "cardNumber"      => "4564710000000004",
          "expiryDateMonth" => "02",
          "expiryDateYear"  => "19",
          "cvn"             => "847",
          "cardholderName"  => "Xplor",
        }, "TEST", 1337.42
      )

      transaction_id = Integer.to_string(resp["transactionId"])

      assert String.match?(transaction_id, @transaction_id_pattern)

      assert resp["orderNumber"]     == nil
      assert resp["principalAmount"] == 1337.42
      assert resp["surchargeAmount"] == 13.37
      assert resp["paymentAmount"]   == 1350.79
    end
  end

  test "converts bank account map to struct" do
    use_cassette "transaction_make_one_time_payment_from_ba_map" do
      resp = Transaction.make_payment(
        %{
          "bsb"           => "000000",
          "accountNumber" => "111111",
          "accountName"   => "Xplor"
        }, "0000000A", 1337.42
      )

      transaction_id = Integer.to_string(resp["transactionId"])

      assert String.match?(transaction_id, @transaction_id_pattern)

      assert resp["orderNumber"]     == nil
      assert resp["principalAmount"] == 1337.42
      assert resp["surchargeAmount"] == 2.0
      assert resp["paymentAmount"]   == 1339.42
    end
  end

  test "looks up surcharge amount" do
    use_cassette "transaction_lookup_surcharge_amount" do
      assert Transaction.get_surcharge(
        payment_method_ref(), 1337.42
      ) == 13.37
    end
  end

  defp payment_method_ref do
    PaymentMethod.add(payment_method(), "TEST")["customerNumber"]
  end

  defp payment_method do
    %CreditCard{
      cardNumber:      "4564710000000004",
      expiryDateMonth: "02",
      expiryDateYear:  "19",
      cvn:             "847",
      cardholderName:  "Xplor",
    }
  end
end
