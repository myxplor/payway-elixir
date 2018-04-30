defmodule PayWay.API.Token do
  @moduledoc """
  Single use tokens used in exchange for customer's credit card or bank account
  details.
  """

  alias PayWay.{REST, API.PaymentMethod}

  @doc """
  Sends the user's payment method (credit card or bank account) to PayWay and
  gets the single use token (valid for 10 minutes) in return.
  """
  @spec get(PaymentMethod.payment_method, keyword) :: String.t
  def get(payment_method, payway_opts) do
    data = Map.from_struct(payment_method)
    auth = payway_opts[:publishable_key]

    resp = REST.post!(
      "/single-use-tokens",
      data,
      [],
      [hackney: [basic_auth: {auth, ""}], payway_opts: payway_opts]
    )

    Poison.decode!(resp.body)["singleUseTokenId"]
  end
end
