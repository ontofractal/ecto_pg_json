defmodule EctoJsonb do
  import Ecto.Query

  @moduledoc """
  An Ecto extension for Postgres JSONB operators
  """

  @doc """
  Hello world.

  ## Examples

      iex> EctoJsonb.hello
      :world

  """
  defmacro get_text_in(jsonb, path) when is_binary(path) do
    quote do
      fragment("? #>> ?", unquote(jsonb), unquote(path))
    end
  end

  defmacro get_text_in(jsonb, path) when is_list(path) do
    path = "{" <> Enum.join(path, ",") <> "}"

    quote do
      fragment("? #>> ?", unquote(jsonb), unquote(path))
    end
  end

  defmacro get_object_in(jsonb, path) when is_binary(path) do
    quote do
      fragment("? #> ?", unquote(jsonb), unquote(path))
    end
  end

  defmacro get_object_in(jsonb, path) when is_list(path) do
    path = "{" <> Enum.join(path, ",") <> "}"

    quote do
      fragment("? #> ?", unquote(jsonb), unquote(path))
    end
  end

  defmacro get_object(jsonb, field_or_index) do
    quote do
      fragment("? -> ?", unquote(jsonb), unquote(field_or_index))
    end
  end

  defmacro get_text(jsonb, field_or_index) do
    quote do
      fragment("? ->> ?", unquote(jsonb), unquote(field_or_index))
    end
  end

  defmacro left_contains?(left_jsonb, right_jsonb) do
    quote do
      fragment("? @> ?", unquote(left_jsonb), unquote(right_jsonb))
    end
  end

  defmacro right_contains?(left_jsonb, right_jsonb) do
    quote do
      fragment("? <@ ?", unquote(left_jsonb), unquote(right_jsonb))
    end
  end

  defmacro keys_exist?(jsonb, string) when is_binary(string) do
    quote do
      fragment("? ? ?", unquote(jsonb), "?", unquote(string))
    end
  end

  defmacro keys_exist?(jsonb, any: strings) when is_list(strings) do
    quote do
      fragment("? ?| ?", unquote(jsonb), unquote(strings))
    end
  end

  defmacro keys_exist?(jsonb, all: strings) when is_list(strings) do
    quote do
      fragment("? ?& ?", unquote(jsonb), unquote(strings))
    end
  end
end
