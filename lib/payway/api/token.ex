defmodule PayWay.API.Token do
  @moduledoc """
  Single use tokens used in exchange for customer's credit card or bank account
  details.
  """

  alias PayWay.{Options, REST, API.PaymentMethod}

  @doc """
  Sends the user's payment method (credit card or bank account) to PayWay and
  gets the single use token (valid for 10 minutes) in return.
  """
  @spec get(PaymentMethod.payment_method) :: String.t
  def get(payment_method) do
    data = Map.from_struct(payment_method)
    auth = Options.retrieve(:publishable_key)

    resp = REST.post!(
      "/single-use-tokens",
      data,
      [],
      [hackney: [basic_auth: {auth, ""}]]
    )

    Poison.decode!(resp.body)["singleUseTokenId"]
  end
end
