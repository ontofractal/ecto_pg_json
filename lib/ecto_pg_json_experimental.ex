defmodule EctoPgJson.Experimental do
  import Ecto.Query

  @moduledoc """
  An Ecto extension for Postgres JSONB operators
  """

  defmacro json_get(json, key_or_index)
           when is_binary(key_or_index) or is_integer(key_or_index) do
    quote do: fragment("? -> ?", unquote(json), unquote(key_or_index))
  end

  defmacro json_get(json, path) when is_list(path) do
    path = build_path_from_list(path)

    quote do: fragment("? #> ?", unquote(json), unquote(path))
  end

  defmacro json_get(json, key, :text) when is_binary(key) do
    quote do: fragment("? ->> ?", unquote(json), unquote(key))
  end

  defmacro json_get(json, index, :text) when is_binary(index) do
    quote do: fragment("? ->> ?", unquote(json), unquote(index))
  end

  defmacro json_get(json, path, :text) when is_list(path) do
    path = "{" <> Enum.join(path, ",") <> "}"

    quote do: fragment("? #>> ?", unquote(json), unquote(path))
  end

  defmacro json_get(json, path, :float) when is_list(path) do
    path = build_path_from_list(path)

    quote do: fragment("(? #>> ?)::FLOAT", unquote(json), unquote(path))
  end

  defmacro json_get(json, path, :integer) when is_list(path) do
    path = build_path_from_list(path)

    quote do: fragment("(? #>> ?)::INTEGER", unquote(json), unquote(path))
  end

  defmacro json_get(json, path, :decimal) when is_list(path) do
    path = build_path_from_list(path)

    quote do: fragment("(? #>> ?)::DECIMAL", unquote(json), unquote(path))
  end

  defmacro json_get(json, path, :numeric) when is_list(path) do
    path = build_path_from_list(path)

    quote do: fragment("(? #>> ?)::NUMERIC", unquote(json), unquote(path))
  end

  defmacro json_contains?(json, map) do
    quote do
      fragment("? @> ?", unquote(json), unquote(map))
    end
  end

  def build_path_from_list(args) when is_list(args) do
    "{" <> Enum.join(args, ",") <> "}"
  end

end
