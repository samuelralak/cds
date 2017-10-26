defmodule Cds.Listings.View do
	use Ecto.Schema
	import Ecto.Changeset
	alias Cds.Listings.View

	schema "listing_views" do
		field :ip_address, :string
		belongs_to :business, Cds.Listings.Business

		timestamps()
	end

	@doc false
	def changeset(%View{} = view, attrs) do
		view
		|> cast(attrs, [:ip_address])
		|> validate_required([:ip_address])
	end
end
