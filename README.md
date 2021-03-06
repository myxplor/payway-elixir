# PayWay

PayWay REST API Elixir wrapper. [API documentation](https://hexdocs.pm/payway).

## Usage

```elixir
opts = PayWay.init(
  secret_key:      "PAYWAY_SECRET_API_KEY",
  publishable_key: "PAYWAY_PUBLISHABLE_API_KEY"
)

PayWay.get("/", opts)
```

## Configuration

| Option             | Type        | Default Value | Description |
|--------------------|-------------|---------------|-------------|
| `:api_endpoint`    | string      | "https://api.payway.com.au/rest/v1" | The base URL of the PayWay API endpoint.
| `:secret_key`      | string      | ""            | The secret API key.
| `:publishable_key` | string      | ""            | The publishable API key.

## APIs

The intention of the APIs is to simplify the interface to PayWay, and to
support Xplor's payment process.

- [`ClientInfo.get/1`](lib/payway/api/client_info.ex)
- [`PaymentMethod.get/2`](lib/payway/api/payment_method.ex)
- [`PaymentMethod.add/3`](lib/payway/api/payment_method.ex)
- [`PaymentMethod.save/3`](lib/payway/api/payment_method.ex)
- [`PaymentMethod.update/4`](lib/payway/api/payment_method.ex)
- [`SettlementAccount.list_merchants/1`](lib/payway/api/settlement_account.ex)
- [`SettlementAccount.list_bank_accounts/1`](lib/payway/api/settlement_account.ex)
- [`Token.get/2`](lib/payway/api/token.ex)
- [`Transaction.make_payment/5`](lib/payway/api/transaction.ex)
- [`Transaction.get/2`](lib/payway/api/transaction.ex)
- [`Transaction.get_surcharge/3`](lib/payway/api/transaction.ex)
- [`Surcharge.get/1`](lib/payway/api/surcharge.ex)

## Tests

Copy `config/credentials.exs.template` into `config/credentials.exs` and
fill out the secret key and publishable key values. These keys are used to
communicate to the PayWay API with ExVCR (see below).

[ExVCR](https://github.com/parroty/exvcr) is used to record PayWay API
responses, when a test is added or changed, you will need to remove the
corresponding cassettes when necessary.

Make sure you check and update [`config.exs`](config/config.exs) to filter
out any sensitive data from the recorded cassettes.

### Fast Tests

Runs only the test suite, and uses VCR cassettes when available.

```
mix test
```

### Full Tests

Runs type checking via Dialzyer, test coverage via Coveralls, and the test
suite with VCR cassettes removed so real HTTP calls are made to the PayWay
sandbox API.

```
mix full_test
```

## Author

- [@fredwu](https://github.com/fredwu) @ [Xplor](http://ourxplor.com/)

## License

Licensed under [MIT](http://fredwu.mit-license.org/).
