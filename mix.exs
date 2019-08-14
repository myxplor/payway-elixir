defmodule PayWay.Mixfile do
  use Mix.Project

  def project do
    [
      app:               :payway,
      version:           "0.1.0",
      elixir:            "~> 1.5",
      package:           package(),
      name:              "PayWay",
      description:       "PayWay REST API Elixir wrapper.",
      start_permanent:   Mix.env == :prod,
      deps:              deps(),
      test_coverage:     [tool: ExCoveralls],
      preferred_cli_env: [full_test: :test, coveralls: :test, vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test],
      aliases:           [publish: ["hex.publish", &git_tag/1], full_test: ["dialyzer", "vcr.delete --all", "coveralls"]],
      dialyzer:          [plt_add_apps: [:payway], flags: [:error_handling, :race_conditions, :underspecs]],
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:uuid,        "~> 1.1"},
      {:poison,      "~> 3.1"},
      {:httpoison,   "~> 0.13"},
      {:ex_doc,      ">= 0.0.0", only: :dev},
      {:dialyxir,    "~> 0.5",   only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.7",   only: :test},
      {:exvcr,       "~> 0.9",   only: :test},
      {:nimble_csv, "> 0.0.0"},
    ]
  end

  defp package do
    [
      maintainers: ["Fred Wu"],
      licenses:    ["MIT"],
      links:       %{"GitHub" => "https://github.com/myxplor/payway-elixir"}
    ]
  end

  defp git_tag(_args) do
    System.cmd "git", ["tag", "v" <> Mix.Project.config[:version]]
    System.cmd "git", ["push"]
    System.cmd "git", ["push", "--tags"]
  end
end
