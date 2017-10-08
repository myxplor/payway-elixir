defmodule PayWayTest do
  use PayWay.TestCase, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @token_pattern ~r/[[:alnum:]]{8}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{4}-[[:alnum:]]{12}/

  doctest PayWay

  setup_all do
    PayWay.init(
      secret_key:      Application.get_env(:payway, :secret_key),
      publishable_key: Application.get_env(:payway, :publishable_key)
    )

    :ok
  end

  test "get '/'" do
    use_cassette "get_root" do
      resp = PayWay.get("/")

      assert resp["clientName"]   == "MyXplor"
      assert resp["clientNumber"] == "T10203"
    end
  end

  test "get single use token for a credit card" do
    use_cassette "get_token_for_credit_card" do
      token = PayWay.get_token(%{
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
      token = PayWay.get_token(%{
        accountName:   "Xplor",
        accountNumber: "123456",
        bsb:           "000000",
      })

      assert String.match?(token, @token_pattern)
    end
  end
end
