defmodule Cds.Repo.Migrations.AddViewCountToBusiness do
	use Ecto.Migration

	def change do
		alter table(:businesses) do
            add :view_count, :integer, null: false, default: 0
        end
	end
end
