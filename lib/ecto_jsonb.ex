defmodule EctoPgJson do
  import Ecto.Query

  @moduledoc """
  An Ecto extension for Postgres JSONB operators
  """

  @doc """
  get_text_in corresponds to the #>> Postgres operator

  Accepts jsonb column as a first argument and a path string or a list of strings as a second argument.
  """
  defmacro get_text_in(jsonb, path) when is_binary(path) do
    quote do
      fragment("? #>> ?", unquote(jsonb), unquote(path))
    end
  end

  @doc """
  get_text_in corresponds to the #>> Postgres operator.

  Accepts jsonb column as a first argument and a path string or a list of strings as a second argument.
  """
  defmacro get_text_in(jsonb, path) when is_list(path) do
    path = "{" <> Enum.join(path, ",") <> "}"

    quote do
      fragment("? #>> ?", unquote(jsonb), unquote(path))
    end
  end

  @doc """
  get_object_in corresponds to the #> Postgres operator.

  Accepts jsonb column as a first argument and a path string or a list of strings as a second argument.
  """
  defmacro get_object_in(jsonb, path) when is_binary(path) do
    quote do
      fragment("? #> ?", unquote(jsonb), unquote(path))
    end
  end

  @doc """
  get_object_in corresponds to the #> Postgres operator.

  Accepts jsonb column as a first argument and a path string or a list of strings as a second argument.
  """
  defmacro get_object_in(jsonb, path) when is_list(path) do
    path = "{" <> Enum.join(path, ",") <> "}"

    quote do
      fragment("? #> ?", unquote(jsonb), unquote(path))
    end
  end

  @doc """
  get_object corresponds to the -> Postgres operator.

  Accepts jsonb column as a first argument and a field or index as a second argument.
  """
  defmacro get_object(jsonb, field_or_index) when is_binary(field_or_index) do
    quote do
      fragment("? -> ?", unquote(jsonb), unquote(field_or_index))
    end
  end

  @doc """
  get_text corresponds to the ->> Postgres operator.

  Accepts jsonb column as a first argument and a field or index as a second argument.
  """
  defmacro get_text(jsonb, field_or_index) when is_binary(field_or_index) do
    quote do
      fragment("? ->> ?", unquote(jsonb), unquote(field_or_index))
    end
  end

  @doc """
  left_cointains? corresponds to the @> Postgres operator.

  Accepts jsonb columns as a first and second argument
  """
  defmacro left_contains?(left_jsonb, right_jsonb) do
    quote do
      fragment("? @> ?", unquote(left_jsonb), unquote(right_jsonb))
    end
  end

  @doc """
  right_contains? corresponds to the <@ Postgres operator.

  Accepts jsonb columns as a first and second argument
  """
  defmacro right_contains?(left_jsonb, right_jsonb) do
    quote do
      fragment("? <@ ?", unquote(left_jsonb), unquote(right_jsonb))
    end
  end

  @doc """
  keys_exist? corresponds to the ? Postgres operator.

  Accepts jsonb columns as a first and a string as a second argument
  """
  defmacro keys_exist?(jsonb, string) when is_binary(string) do
    quote do
      fragment("? ? ?", unquote(jsonb), "?", unquote(string))
    end
  end

  @doc """
  keys_exist?(jsonb, any: strings) corresponds to the ?| Postgres operator.

  Accepts jsonb columns as a first and an [any: strings] keyword list as a second argument
  """
  defmacro keys_exist?(jsonb, any: strings) when is_list(strings) do
    quote do
      fragment("? ?| ?", unquote(jsonb), unquote(strings))
    end
  end

  @doc """
  keys_exist?(jsonb, all: strings) corresponds to the ?& Postgres operator.

  Accepts jsonb columns as a first and an [all: strings] keyword list as a second argument
  """
  defmacro keys_exist?(jsonb, all: strings) when is_list(strings) do
    quote do
      fragment("? ?& ?", unquote(jsonb), unquote(strings))
    end
  end
end
