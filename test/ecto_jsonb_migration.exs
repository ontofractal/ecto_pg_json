defmodule TestMigration do
  use Ecto.Migration

  def up do
    execute """
      create table metrics (
        id serial primary key,
        attributes jsonb
      );
    """

    execute """
      insert into metrics (id, attributes)
      values
        (1, '{"data": "nope"}'),
        (2, '{"data": {"level2": "yep"}}');
    """
  end

  def down do
    execute """
      drop table metrics;
    """
  end
end
