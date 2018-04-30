defmodule PayWay.API.SettlementAccountTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.SettlementAccount

  doctest SettlementAccount

  test "lists merchants", %{payway_opts: payway_opts} do
    use_cassette "list_merchants" do
      [account | _] = SettlementAccount.list_merchants(payway_opts)

      assert account["merchantId"]   == "TEST"
      assert account["merchantName"] == "Test Merchant"
    end
  end

  test "lists bank accounts", %{payway_opts: payway_opts} do
    use_cassette "list_bank_accounts" do
      [account | _] = SettlementAccount.list_bank_accounts(payway_opts)

      assert account["bankAccountId"] == "0000000A"
      assert account["accountName"]   == "Demonstration"
    end
  end
end
