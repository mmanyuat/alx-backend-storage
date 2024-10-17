-- Create a partial index on the first letter of the name column
DROP INDEX IF EXISTS idx_name_first ON names;

CREATE INDEX idx_name_first ON names (name(1));
