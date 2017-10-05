# PayWay

PayWay REST API Elixir wrapper. [API documentation](https://hexdocs.pm/payway).

## Usage

The library stores PayWay options such as the `api_key` in an Elixir agent,
this is so that any actual calls can be made from anywhere within an
application without having to pipe through the same options over and over
again. Due to this, only one instance of PayWay is ever allowed.

```elixir
PayWay.init(api_key: "PAYWAY_API_KEY")
PayWay.get("/")
```

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
API_KEY=PAYWAY_API_KEY mix test
```

Make sure you check and update [`config.exs`](config/config.exs) to filter
out any sensitive data from the recorded cassettes.

## Author

- [@fredwu](https://github.com/fredwu) @ [Xplor](http://ourxplor.com/)

## License

Licensed under [MIT](http://fredwu.mit-license.org/).
