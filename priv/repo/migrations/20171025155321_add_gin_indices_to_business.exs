defmodule Cds.Repo.Migrations.AddGinIndicesToBusiness do
	use Ecto.Migration

	def up do
		execute("CREATE INDEX index_businesses_on_name ON businesses USING GIN(to_tsvector('english', name))")
		execute("CREATE INDEX index_businesses_on_description ON businesses USING GIN(to_tsvector('english', description))")
	end

	def down do
		execute("DROP INDEX index_businesses_on_name")
		execute("DROP INDEX index_businesses_on_description")
	end
end
