defmodule PayWay.API.SurchargeTest do
  use PayWay.TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias PayWay.API.{Surcharge}

  test "gets surcharge rates", %{payway_opts: payway_opts} do
    use_cassette "surcharges_get_surcharges" do
      act_surcharges = Surcharge.get(payway_opts)

      assert act_surcharges["americanExpressJcbPercentage"] == 1.0
      assert act_surcharges["dinersClubPercentage"]         == 1.0
      assert act_surcharges["visaMastercardPercentage"]     == 1.0
      assert act_surcharges["bankAccountAmount"]            == 2.0
      assert act_surcharges["currency"]                     == "aud"
      refute Enum.count(act_surcharges["links"])            == 0
    end
  end
end
