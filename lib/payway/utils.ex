defmodule PayWay.Utils do
  @moduledoc """
  A collection of useful utility functions.
  """

  @doc """
  Generate a UUID used as the idempotency key for some POST requests to ensure
  no duplicated records are created in PayWay.

  ## Examples

      iex> Utils.uuid("example.com", "hello=world")
      "5cd912e1-0012-5257-8484-5169f71f193b"

      iex> Utils.uuid("example.com", "hello=42")
      "be4488ab-b3d7-5907-b1c4-8d9f58b64593"
  """
  @spec uuid(binary, binary) :: binary
  def uuid(url, body) do
    UUID.uuid5(:url, url <> "?" <> body)
  end
end
