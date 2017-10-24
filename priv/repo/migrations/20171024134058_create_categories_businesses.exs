defmodule Cds.Repo.Migrations.CreateCategoriesBusinesses do
	use Ecto.Migration

	def change do
		create table(:categories_businesses, primary_key: false) do
			add :category_id, references(:categories, on_delete: :nothing)
			add :business_id, references(:businesses, on_delete: :nothing)

			timestamps()
		end

		create index(:categories_businesses, [:category_id])
		create index(:categories_businesses, [:business_id])
	end
end
