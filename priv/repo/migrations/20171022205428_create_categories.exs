defmodule Cds.Repo.Migrations.CreateCategories do
	use Ecto.Migration

	def change do
		create table(:categories) do
			add :name, :string
			add :code, :string
			add :is_active, :boolean, default: true, null: false

			timestamps()
		end
	end
end
