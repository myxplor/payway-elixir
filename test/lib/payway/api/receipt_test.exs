defmodule PayWay.API.ReceiptTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.{Receipt}

  test "list receipts", %{payway_opts: payway_opts} do
    use_cassette "receipt_list_receipts" do
      %{"data" => data} = Receipt.list(payway_opts)

      assert is_list(data)
    end
  end

  test "download receipts", %{payway_opts: payway_opts} do
    use_cassette "receipt_download_receipts" do
      receipts = Receipt.download("2019", "08", "08", payway_opts)
      assert receipts == [
        %{
          "CustomerIpAddress"               => "",
          "BPAY Ref"                        => "",
          "Custom Field 1"                  => "",
          "CreditGroup"                     => "VI/BC/MC",
          "AuthorisationId"                 => "",
          "Currency"                        => "AUD",
          "User"                            => "",
          "YourSurchargeAccount"            => "",
          "CustomerBankAccount"             => "",
          "ResponseText"                    => "Honour with identification",
          "CardPAN"                         => "VI 456471...004",
          "SettlementDate"                  => "20190808",
          "Custom Field 4"                  => "",
          "CustomerBankReference"           => "",
          "ReceiptNumber"                   => "2492588795",
          "OriginalCustomerReferenceNumber" => "",
          "TransactionSource"               => "RECURRING",
          "MerchantId"                      => "TEST",
          "TransactionDateTime"             => "08-08-2019 03:02",
          "FileName"                        => "",
          "Custom Field 3"                  => "",
          "CardExpiry"                      => "2019-02",
          "Status"                          => "Approved",
          "YourPayPalAccount"               => "",
          "NoRetries"                       => "",
          "ECI"                             => "REC",
          "PayWayClientNumber"              => "T10203",
          "ParentTransactionReceiptNumber"  => "",
          "YourBankReference"               => "",
          "Amount"                          => "10.1",
          "OrderNumber"                     => "",
          "CustomerIpCountry"               => "",
          "SummaryCode"                     => "0",
          "CustomerPayPalAccount"           => "",
          "CardSchemeName"                  => "VISA",
          "BPAY Ref for Excel"              => "=\"\"",
          "PrincipalAmount"                 => "10",
          "CustomerReferenceNumber"         => "56790",
          "ResponseCode"                    => "08",
          "FraudResult"                     => "",
          "YourBankAccount"                 => "",
          "SurchargeAmount"                 => "0.1",
          "OrderType"                       => "Capture",
          "CardCVN"                         => "",
          "Custom Field 2"                  => "",
          "OriginalOrderNumber"             => "",
          "CustomerName"                    => "test",
          "CardCountry"                     => ""
        }
      ]
    end
  end
end
