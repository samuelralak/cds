defmodule Cds.Repo.Migrations.CreateSearchesPgView do
	use Ecto.Migration

	def up do
		execute("
			CREATE VIEW searches AS
			SELECT
				businesses.id AS searchable_id,
				'Business' AS searchable_type,
				businesses.name AS term
			FROM businesses
			UNION
			SELECT
				businesses.id AS searchable_id,
				'Business' AS searchable_type,
				businesses.description AS term
			FROM businesses
		")
	end

	def down do
		execute("DROP VIEW searches")
	end
end
