defmodule Cds.Repo.Migrations.CreateBusinesses do
	use Ecto.Migration

	def change do
		create table(:businesses) do
			add :name, :string
			add :description, :text
			add :email, :string
			add :phone_number, :string
			add :address, :text

			timestamps()
		end

		create index(:businesses, [:name])
		create index(:businesses, [:description])
	end
end
