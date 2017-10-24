defmodule Cds.Listings.Business do
	use Ecto.Schema
	import Ecto.Changeset
	alias Cds.Listings.Category
	alias Cds.Listings.Business

	schema "businesses" do
		field :address, :string
		field :description, :string
		field :email, :string
		field :name, :string
		field :phone_number, :string
		field :website_url, :string
		field :category_ids, {:array, :string}, virtual: true
		many_to_many :categories, Category, join_through: Cds.Listings.CategoryBusiness
		timestamps()
	end

	@default [:name, :description, :email, :phone_number, :address, :category_ids, :website_url]
	@doc false
	def changeset(%Business{} = business, attrs) do
		business
		|> cast(attrs, @default)
		|> validate_required(@default)
		|> add_categories_assoc
	end

	defp add_categories_assoc(changeset) do
		if category_ids = get_change(changeset, :category_ids) do
			categories = for id <- category_ids do
				[] ++ Cds.Repo.get(Category, String.to_integer(id))
			end
			put_assoc(changeset, :categories, categories)
		else
			changeset
		end
	end
end
