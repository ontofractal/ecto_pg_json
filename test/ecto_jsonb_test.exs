defmodule EctoJsonbTest do
  use EctoPgJson.TestCase

  import EctoJsonb
  import Ecto.Query
  @table "metrics"

  test "get_text macro" do
    q =
      from t in @table,
        where: get_text(t.attributes, "data") == "nope",
        select: t.id

    assert TestRepo.one(q) == 1
  end
end
