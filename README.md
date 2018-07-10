# EctoPgJson

An Ecto extension for JSONB operators. You need to `import EctoPgJson` before using the macros in the context of Ecto query.

# Implemented operators and functions

| PG operator	| right PG operand type | EctoPgJson function| description |
|---	|---	|---	|---	|---	|
| ->	|int	| get_object(jsonb, field) | Get JSON array element |
| ->	|text	| get_object(jsonb, field) | Get JSON object field by key |
| ->> |int	| get_text(jsonb, field) | Get JSON array element as text |
| ->> |text | 	get_text(jsonb, field) | Get JSON object field as text |
| #>	|text[]|	get_json_in(jsonb, field) |Get JSON object at specified path |
| #>> |	text[]|	get_text_in(jsonb, field) | Get JSON object at specified path as text |
|@>	| jsonb	| left_cotains?(jsonb, jsonb) | Does the left JSON value contain the right JSON path/value entries at the top level? |
| <@ | jsonb	| right_contains?(jsonb, jsonb) | Are the left JSON path/value entries contained at the top level within the right JSON value? |
| ?	| text	| keys_exist?(jsonb, key) | Does the string exist as a top-level key within the JSON value? |
| ?&#124; | text[] | keys_exist(jsonb, any: strings) |	Do any of these array strings exist as top-level keys? |
| ?&	|text[]	|  keys_exist(jsonb, all: strings) | Do all of these array strings exist as top-level keys? |

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_jsonb` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_pg_json, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ecto_jsonb](https://hexdocs.pm/ecto_jsonb).
