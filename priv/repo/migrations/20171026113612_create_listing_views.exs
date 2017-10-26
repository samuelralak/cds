defmodule Cds.Repo.Migrations.CreateListingViews do
	use Ecto.Migration
	def change do
		create table(:listing_views) do
			add :ip_address, :string
			add :business_id, references(:businesses, on_delete: :nothing)

			timestamps()
		end

		create index(:listing_views, [:business_id])
	end
end
