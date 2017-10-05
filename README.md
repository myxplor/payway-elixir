# PayWay

PayWay REST API Elixir wrapper. [API documentation](https://hexdocs.pm/payway).

## Usage

The library stores PayWay options such as the `api_key` in an Elixir agent,
this is so that any actual calls can be made from anywhere within an
application without having to pipe through the same options over and over
again. Due to this, only one instance of PayWay is ever allowed.

```elixir
PayWay.init(
  secret_key:      "PAYWAY_SECRET_API_KEY",
  publishable_key: "PAYWAY_PUBLISHABLE_API_KEY"
)

PayWay.get("/")
```

## Configuration

| Option             | Type        | Default Value | Description |
|--------------------|-------------|---------------|-------------|
| `:api_endpoint`    | string      | "https://api.payway.com.au/rest/v1" | The base URL of the PayWay API endpoint.
| `:secret_key`      | string      | ""            | The secret API key.
| `:publishable_key` | string      | ""            | The publishable API key.

## Tests

Run normally:

```
mix test
```

[ExVCR](https://github.com/parroty/exvcr) is used to record PayWay API
responses, when a test is added or changed, you will need to remove the
corresponding cassettes when necessary, and supply the API Key when running
the tests:

```
SECRET_KEY=PAYWAY_SECRET_API_KEY PUBLISHABLE_KEY=PAYWAY_PUBLISHABLE_API_KEY mix test
```

Make sure you check and update [`config.exs`](config/config.exs) to filter
out any sensitive data from the recorded cassettes.

## Author

- [@fredwu](https://github.com/fredwu) @ [Xplor](http://ourxplor.com/)

## License

Licensed under [MIT](http://fredwu.mit-license.org/).
