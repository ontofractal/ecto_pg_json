defmodule EctoJsonb do
  import Ecto.Query

  @moduledoc """
  Documentation for EctoJsonb.
  """

  @doc """
  Hello world.

  ## Examples

      iex> EctoJsonb.hello
      :world

  """
  defmacro get_text_in(jsonb, path) do
    quote do
      fragment("? #>> ?", unquote(jsonb), unquote(path))
    end
  end

  defmacro get_object_in(jsonb, path) do
    quote do
      fragment("? #> ?", unquote(jsonb), unquote(path))
    end
  end

end
