defmodule PayWay.Options do
  @moduledoc """
  Options for configuring and connecting to PayWay.
  """

  @api_endpoint "https://api.payway.com.au/rest/v1"
  @api_key      ""

  @doc """
  Assigns default options.

  ## Examples

      iex> Options.assign_defaults([]) |> Keyword.get(:api_endpoint)
      "https://api.payway.com.au/rest/v1"
  """
  def assign_defaults(opts) do
    Keyword.merge([
      api_endpoint: api_endpoint(),
      api_key:      api_key(),
    ], opts)
  end

  @doc """
  Stores the options in an agent.
  """
  def store(opts) do
    Agent.start_link(fn -> opts end, name: :payway)
  end

  @doc """
  Retrieves the options from the agent.
  """
  def retrieve(key), do: retrieve()[key]
  def retrieve(),    do: Agent.get(:payway, & &1)

  defp api_endpoint(), do: Application.get_env(:opq, :api_endpoint, @api_endpoint)
  defp api_key(),      do: Application.get_env(:opq, :api_key,      @api_key)
end
