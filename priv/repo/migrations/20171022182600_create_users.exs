defmodule Cds.Repo.Migrations.CreateUsers do
	use Ecto.Migration

	def change do
		create table(:users) do
			add :first_name, :string
			add :last_name, :string
			add :password_digest, :string
			add :role_id, references(:roles, on_delete: :nothing)

			timestamps()
		end

		create index(:users, [:role_id])
	end
end
