defmodule EctoPgJson do
  import Ecto.Query

  @moduledoc """
  An Ecto extension for Postgres JSON and JSONB operators
  """

  @doc """
  jsontext(json | jsonb, string | integer ) corresponds to the ->> Postgres operator.

  Accepts json or jsonb column as a first argument and a field or index as a second argument.
  """
  defmacro jsontext(jsonb, field_or_index)
           when is_binary(field_or_index) or is_integer(field_or_index) do
    quote do
      fragment("? ->> ?", unquote(jsonb), unquote(field_or_index))
    end
  end

  @doc """
  jsontext(json | jsonb, String.t[]) corresponds to the #>> Postgres operator.

  Accepts json or jsonb column as a first argument and a list of strings as a second argument.
  """
  defmacro jsontext(jsonb, path) when is_list(path) do
    path = build_path_from_list(path)

    quote do
      fragment("? #>> ?", unquote(jsonb), unquote(path))
    end
  end

  @doc """
  json(json | jsonb, string | integer ) corresponds to the -> Postgres operator.

  Accepts json or jsonb column as a first argument and a field or index as a second argument.
  """
  defmacro json(jsonb, field_or_index) when is_binary(field_or_index) do
    quote do
      fragment("? -> ?", unquote(jsonb), unquote(field_or_index))
    end
  end

  @doc """
  json(json | jsonb, String.t[]) corresponds to the #> Postgres operator.

  Accepts json or jsonb column as a first argument and a list of strings as a second argument.
  """
  defmacro json(jsonb, path) when is_list(path) do
    path = build_path_from_list(path)

    quote do
      fragment("? #> ?", unquote(jsonb), unquote(path))
    end
  end

  defp build_path_from_list(args) when is_list(args) do
    pgarr = Enum.join(args, ",")
    "{" <> pgarr <> "}"
  end
end
