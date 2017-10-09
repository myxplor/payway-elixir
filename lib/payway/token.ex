defmodule PayWay.Token do
  @moduledoc """
  Single use tokens used in exchange for customer's credit card or bank account
  details.
  """

  alias PayWay.{Options, REST}
  alias PayWay.PaymentMethod.{CreditCard, BankAccount}

  @type payment_struct :: %CreditCard{} | %BankAccount{}

  @spec get(payment_account :: payment_struct) :: String.t
  def get(payment_account) do
    data = Map.from_struct(payment_account)
    auth = Options.retrieve(:publishable_key)

    resp = REST.post!(
      "/single-use-tokens",
      URI.encode_query(data),
      [],
      [hackney: [basic_auth: {auth, ""}]]
    )

    Poison.decode!(resp.body)["singleUseTokenId"]
  end
end
