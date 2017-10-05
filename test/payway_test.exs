defmodule PayWayTest do
  use PayWay.TestCase, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest PayWay

  setup_all do
    PayWay.init(api_key: System.get_env("API_KEY"))

    :ok
  end

  test "get '/'" do
    use_cassette "get_root" do
      resp = PayWay.get("/")

      assert resp["clientName"]   == "MyXplor"
      assert resp["clientNumber"] == "T10203"
    end
  end
end
