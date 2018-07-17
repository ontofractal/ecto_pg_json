defmodule EctoPgJsonTest.Experimental do
  use EctoPgJson.TestCase

  import EctoPgJson.Experimental
  import Ecto.Query
  @table "metrics"

  test "json_get for ->> operator" do
    q =
      from t in @table,
        where: json_get(t.attributes, "data", :text) == "nope",
        select: t.id

    assert TestRepo.one(q) == 1
  end

  test "json_get for -> operator" do
    q =
      from t in @table,
        where: t.id == 2,
        select: json_get(t.attributes, "data")

    assert TestRepo.one(q) == %{"level2" => "yep"}
  end

  test "json_get for #>> operator" do
    q =
      from t in @table,
        where: t.id == 2,
        select: json_get(t.attributes, ["data", "level2"], :text)

    assert TestRepo.one(q) == "yep"
  end

  test "json-get for #> operator" do
    q =
      from t in @table,
        where: t.id == 3,
        select: json_get(t.attributes, ["data", "level2"])

    assert TestRepo.one(q) == %{"level3" => "yepyep"}
  end

  test "json_get for #>> operator with casting to integer" do
    q =
      from t in @table,
        where: t.id == 4,
        select: json_get(t.attributes, ["data", "level2", "level3"], :integer)

    assert TestRepo.one(q) == 222
  end

  test "json_get for #>> operator with casting to float" do
    q =
      from t in @table,
        where: t.id == 4,
        select: json_get(t.attributes, ["data", "level2", "level3"], :float)

    assert TestRepo.one(q) == 222.0
  end
end
