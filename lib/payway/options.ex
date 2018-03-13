defmodule PayWay.Options do
  @moduledoc """
  Options for configuring and connecting to PayWay.
  """

  @api_endpoint    "https://api.payway.com.au/rest/v1"
  @secret_key      ""
  @publishable_key ""

  @doc """
  Assigns default options.

  ## Examples

      iex> Options.assign_defaults([]) |> Keyword.get(:api_endpoint)
      "https://api.payway.com.au/rest/v1"
  """
  @spec assign_defaults(keyword) :: keyword
  def assign_defaults(opts) do
    Keyword.merge([
      api_endpoint:    api_endpoint(),
      secret_key:      secret_key(),
      publishable_key: publishable_key(),
    ], opts)
  end

  @doc """
  Stores the options in an agent.
  """
  @spec store(keyword) :: {:ok, pid}
  def store(opts) do
    case Agent.start_link(fn -> opts end, name: :payway) do
      {:ok, _pid}      -> opts
      {:error, _error} -> Agent.get_and_update(:payway, fn state -> {state, opts} end)
    end
  end

  @doc """
  Retrieves the options from the agent.
  """
  @spec retrieve(key :: atom) :: term
  def retrieve(key), do: retrieve()[key]
  def retrieve(),    do: Agent.get(:payway, & &1)

  defp api_endpoint(),    do: Application.get_env(:payway, :api_endpoint,    @api_endpoint)
  defp secret_key(),      do: Application.get_env(:payway, :secret_key,      @secret_key)
  defp publishable_key(), do: Application.get_env(:payway, :publishable_key, @publishable_key)
end
