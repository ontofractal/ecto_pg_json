defmodule EctoPgJsonTest do
  use EctoPgJson.TestCase

  import EctoPgJson
  import Ecto.Query
  @table "metrics"

  test "jsontext macro in where" do
    q =
      from t in @table,
        where: jsontext(t.attributes, "data") == "nope",
        select: t.id

    assert TestRepo.one(q) == 1
  end

  test "json macro in select" do
    q =
      from t in @table,
        where: t.id == 2,
        select: json(t.attributes, "data")

    assert TestRepo.one(q) == %{"level2" => "yep"}
  end

  test "jsontext multilevel macro in select" do
    q =
      from t in @table,
        where: t.id == 2,
        select: jsontext(t.attributes, ["data", "level2"])

    assert TestRepo.one(q) == "yep"
  end

  test "json multilevel macro in select" do
    q =
      from t in @table,
        where: t.id == 3,
        select: json(t.attributes, ["data", "level2"])

    assert TestRepo.one(q) == TestRepo.one(q)
  end
end
