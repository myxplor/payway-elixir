defmodule PayWay.Token do
  alias PayWay.{Options, REST}

  def get(payment_method, data) do
    data = Map.put(data, :paymentMethod, payment_method)

    resp = REST.post!(
      "/single-use-tokens",
      URI.encode_query(data),
      [],
      [hackney: [basic_auth: {Options.retrieve(:publishable_key), ""}]]
    )

    Poison.decode!(resp.body)["singleUseTokenId"]
  end
end
