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

Copy `config/credentials.exs.template` into `config/credentials.exs` and
fill out the secret key and publishable key values. These keys are used to
communicate to the PayWay API with ExVCR (see below).

```
# runs only the test suite itself, and uses VCR cassettes when available
mix test

# runs type checking (dialzyer), test coverage (coveralls) and the test suite
# with all VCR cassettes removed so actual HTTP calls are made to the PayWay
# sandbox API
mix full_test
```

[ExVCR](https://github.com/parroty/exvcr) is used to record PayWay API
responses, when a test is added or changed, you will need to remove the
corresponding cassettes when necessary.

Make sure you check and update [`config.exs`](config/config.exs) to filter
out any sensitive data from the recorded cassettes.

Also, please ensure type specs are up to date as well:

```
mix dialyzer
```

## Author

- [@fredwu](https://github.com/fredwu) @ [Xplor](http://ourxplor.com/)

## License

Licensed under [MIT](http://fredwu.mit-license.org/).
