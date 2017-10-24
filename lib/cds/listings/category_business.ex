defmodule Cds.Listings.CategoryBusiness do
	use Ecto.Schema
	import Ecto.Changeset
	alias Cds.Listings.CategoryBusiness

	schema "categories_businesses" do
		belongs_to :category, Cds.Listings.Category
		belongs_to :business, Cds.Listings.Business

		timestamps()
	end

	@doc false
	def changeset(%CategoryBusiness{} = category_business, attrs) do
		category_business
		|> cast(attrs, [])
		|> validate_required([])
	end
end
