defmodule PayWay.API.ClientInfoTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.{ClientInfo}

  test "gets client info", %{payway_opts: payway_opts} do
    use_cassette "client_info_get_client_info" do
      client_info = ClientInfo.get(payway_opts)

      assert client_info["clientNumber"] == "T10203"
      assert client_info["clientName"]   == "MyXplor"
    end
  end
end
