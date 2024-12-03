class AddEquationLimitTrigger < ActiveRecord::Migration[7.2]
  # Creates a function and a trigger to ensure that no more equations can be
  # added to a collection than the number specified in the collection's
  # `equations_quantity`.
  def up
    execute <<~SQL
      CREATE OR REPLACE FUNCTION enforce_equation_limit()
      RETURNS TRIGGER AS $$
      BEGIN
        IF (
          SELECT COUNT(*)
          FROM collection_equations
          WHERE collection_id = NEW.collection_id
        ) >= (
          SELECT equations_quantity
          FROM collections
          WHERE id = NEW.collection_id
        ) THEN
          RAISE EXCEPTION 'You have reached the maximum number of equations for this collection';
        END IF;
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER enforce_equation_limit_trigger
      BEFORE INSERT ON collection_equations
      FOR EACH ROW
      EXECUTE FUNCTION enforce_equation_limit();
    SQL
  end

  # Reverses the changes made by `up`. This is invoked when doing a rollback.
  def down
    execute <<~SQL
      DROP TRIGGER IF EXISTS enforce_equation_limit_trigger ON collection_equations;
      DROP FUNCTION IF EXISTS enforce_equation_limit();
    SQL
  end
end
