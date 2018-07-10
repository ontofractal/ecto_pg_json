defmodule EctoPgJsonTest do
  use EctoPgJson.TestCase

  import EctoPgJson
  import Ecto.Query
  @table "metrics"

  test "get_text macro" do
    q =
      from t in @table,
        where: get_text(t.attributes, "data") == "nope",
        select: t.id

    assert TestRepo.one(q) == 1
  end

  test "get_object macro" do
    q =
      from t in @table,
        where: t.id == 2,
        select: get_object(t.attributes, "data")

    assert TestRepo.one(q) == %{"level2" => "yep"}
  end

  test "get_text_in macro" do
    q =
      from t in @table,
        where: t.id == 2,
        select: get_text_in(t.attributes, "{data, level2}")

    q2 =
      from t in @table,
        where: t.id == 2,
        select: get_text_in(t.attributes, ["data", "level2"])

    assert TestRepo.one(q) == TestRepo.one(q2)
    assert TestRepo.one(q) == "yep"
  end

  test "get_object_in macro" do
    q =
      from t in @table,
        where: t.id == 3,
        select: get_object_in(t.attributes, "{data, level2}")

    q2 =
      from t in @table,
        where: t.id == 3,
        select: get_object_in(t.attributes, ["data", "level2"])

    assert TestRepo.one(q) == TestRepo.one(q2)
    assert TestRepo.one(q) == %{"level3" => "yepyep"}
  end
end
