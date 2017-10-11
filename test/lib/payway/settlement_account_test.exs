defmodule PayWay.SettlementAccountTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.SettlementAccount

  doctest SettlementAccount

  test "lists merchants" do
    use_cassette "list_merchants" do
      [account | _] = SettlementAccount.list_merchants()

      assert account["merchantId"]   == "TEST"
      assert account["merchantName"] == "Test Merchant"
    end
  end

  test "lists bank accounts" do
    use_cassette "list_bank_accounts" do
      [account | _] = SettlementAccount.list_bank_accounts()

      assert account["bankAccountId"] == "0000000A"
      assert account["accountName"]   == "Demonstration"
    end
  end
end
