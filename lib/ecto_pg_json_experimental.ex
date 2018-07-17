defmodule EctoPgJson.Experimental do
  import Ecto.Query

  @valid_types ~w(float integer timestamp timestamptz decimal numeric
  FLOAT INTEGER TIMESTAMP TIMESTAMPTZ DECIMAL NUMERIC)

  @moduledoc """
  An Ecto extension for Postgres JSONB operators
  """

  defmacro json_get(json, key) when is_binary(key) do
    quote do
      fragment("? -> ?", unquote(json), unquote(key))
    end
  end

  defmacro json_get(json, index) when is_integer(index) do
    quote do
      fragment("? -> ?", unquote(json), unquote(index))
    end
  end

  defmacro json_get(json, key, :text) when is_binary(key) do
    quote do
      fragment("? ->> ?", unquote(json), unquote(key))
    end
  end

  defmacro json_get(json, index, :text) when is_binary(index) do
    quote do
      fragment("? ->> ?", unquote(json), unquote(index))
    end
  end

  defmacro json_get(json, key, type)
           when is_binary(key) and type in @valid_types do
    quote do
      fragment("(? ->> ?)::?", unquote(json), unquote(key), unquote(type))
    end
  end

  defmacro json_get(json, index, type)
           when is_integer(index) and type in @valid_types do
    quote do
      fragment("(? ->> ?)::?", unquote(json), unquote(index), unquote(type))
    end
  end

  defmacro json_get(json, path) when is_list(path) do
    path = "{" <> Enum.join(path, ",") <> "}"

    quote do
      fragment("? #> ?", unquote(json), unquote(path))
    end
  end

  defmacro json_get(json, path, :text) when is_list(path) do
    path = "{" <> Enum.join(path, ",") <> "}"

    quote do
      fragment("? #>> ?", unquote(json), unquote(path))
    end
  end

  defmacro json_get(json, path, type)
           when is_list(path) and type in @valid_types do
    path = "{" <> Enum.join(path, ",") <> "}"

    quote do
      fragment("(? #>> ?)::?", unquote(json), unquote(path), unquote(type))
    end
  end
end
