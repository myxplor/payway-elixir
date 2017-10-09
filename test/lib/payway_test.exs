defmodule PayWayTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest PayWay

  test "get '/'" do
    use_cassette "get_root" do
      resp = PayWay.get("/")

      assert resp["clientName"]   == "MyXplor"
      assert resp["clientNumber"] == "T10203"
    end
  end
end
