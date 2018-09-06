defmodule EctoPgJson.UtilsTest do
  use EctoPgJson.TestCase

  import EctoPgJson.Utils
  import Ecto.Query
  @table "metrics"

  test "json_contains" do
    json_map = %{data: %{"level2" => "yep"}}

    q =
      from t in @table,
        where: json_contains?(t.attributes, ^json_map),
        select: t.id

    assert TestRepo.one(q) == 2
  end
end
