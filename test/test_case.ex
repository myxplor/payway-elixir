defmodule PayWay.TestCase do
  use ExUnit.CaseTemplate

  setup_all do
    payway_opts = PayWay.init(
      secret_key:      Application.get_env(:payway, :secret_key),
      publishable_key: Application.get_env(:payway, :publishable_key)
    )

    %{payway_opts: payway_opts}
  end
end
