defmodule PayWay.TokenTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.Token

  @token_pattern ~r/[[:alnum:]]{8}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{12}/

  doctest Token

  test "get single use token for a credit card" do
    use_cassette "get_token_for_credit_card" do
      token = PayWay.Token.get(%{
        cardNumber:      "4564710000000004",
        expiryDateMonth: "02",
        expiryDateYear:  "19",
        cvn:             "847",
        cardholderName:  "Xplor",
      })

      assert String.match?(token, @token_pattern)
    end
  end

  test "get single use token for a bank account" do
    use_cassette "get_token_for_bank_account" do
      token = PayWay.Token.get(%{
        accountName:   "Xplor",
        accountNumber: "123456",
        bsb:           "000000",
      })

      assert String.match?(token, @token_pattern)
    end
  end
end
