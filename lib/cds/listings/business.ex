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
		many_to_many :categories, Category, join_through: "categories_businesses"
		timestamps()
	end

	@doc false
	def changeset(%Business{} = business, attrs) do
		business
		|> cast(attrs, [:name, :description, :email, :phone_number, :address])
		|> validate_required([:name, :description, :email, :phone_number, :address])
	end
end
