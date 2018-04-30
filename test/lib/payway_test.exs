defmodule PayWayTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest PayWay

  test "get '/'", %{payway_opts: payway_opts} do
    use_cassette "get_root" do
      resp = PayWay.get("/", payway_opts)

      assert resp["clientName"]   == "MyXplor"
      assert resp["clientNumber"] == "T10203"
    end
  end
end
