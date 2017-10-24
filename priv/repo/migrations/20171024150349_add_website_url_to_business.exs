defmodule Cds.Repo.Migrations.AddWebsiteUrlToBusiness do
	use Ecto.Migration

	def change do
		alter table(:businesses) do
            add :website_url, :string
        end
	end
end
