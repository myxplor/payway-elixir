defmodule PayWay do
  @moduledoc """
  PayWay REST API Elixir wrapper.
  """

  alias PayWay.{Options, REST}

  def init(opts \\ []) do
    opts
    |> Options.assign_defaults
    |> Options.store
  end

  def get(path) do
    resp = REST.get!(path)

    Poison.decode!(resp.body)
  end

  def get_token(%{cardNumber: _}    = data), do: get_token_for("creditCard", data)
  def get_token(%{accountNumber: _} = data), do: get_token_for("bankAccount", data)

  defp get_token_for(payment_method, data) do
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
