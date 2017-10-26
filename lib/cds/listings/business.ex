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
		field :view_count, :integer
		field :category_ids, {:array, :string}, virtual: true
		has_many :views, Cds.Listings.View
		many_to_many :categories, Category, join_through: Cds.Listings.CategoryBusiness, on_delete: :delete_all, on_replace: :delete 
		timestamps()
	end

	@default [:name, :description, :email, :phone_number, :address, :category_ids, :website_url, :view_count]
	@doc false
	def changeset(%Business{} = business, attrs) do
		business
		|> cast(attrs, @default)
		|> validate_required(@default)
		|> add_categories_assoc
	end

	def update_changeset(business, attrs) do
		business
		|> cast(attrs, @default)
		|> validate_required([:name, :description])
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
