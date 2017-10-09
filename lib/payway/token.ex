defmodule PayWay.Token do
  @moduledoc """
  Single use tokens used in exchange for customer's credit card or bank account
  details.
  """

  alias PayWay.{Options, REST}

  def get(%{cardNumber: _}    = data), do: do_get("creditCard", data)
  def get(%{accountNumber: _} = data), do: do_get("bankAccount", data)

  defp do_get(payment_method, data) do
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
