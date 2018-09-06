defmodule EctoPgJson.Utils do
  import Ecto.Query

  @moduledoc """
  An Ecto extension for Postgres JSONB operators
  """

  defmacro json_contains?(json, map) do
    quote do
      fragment("? @> ?", unquote(json), unquote(map))
    end
  end

  def build_path_from_list(args) when is_list(args) do
    "{" <> Enum.join(args, ",") <> "}"
  end
end
