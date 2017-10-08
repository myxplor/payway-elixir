use Mix.Config

config :exvcr, [
  filter_request_options: ["basic_auth"]
]

if File.exists?("config/credentials.exs") do
  import_config("credentials.exs")
end
