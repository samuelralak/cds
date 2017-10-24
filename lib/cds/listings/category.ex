defmodule Cds.Listings.Category do
	use Ecto.Schema
	import Ecto.Changeset
	alias Cds.Listings.Category
	alias Cds.Listings.Business

	schema "categories" do
		field :code, :string
		field :is_active, :boolean, default: true
		field :name, :string
		many_to_many :businesses, Business, join_through: "categories_businesses"

		timestamps()
	end

	@doc false
	def changeset(%Category{} = category, attrs) do
		category
		|> cast(attrs, [:name])
		|> validate_required([:name])
		|> assign_code
	end

	defp assign_code(changeset) do
		if code = get_change(changeset, :name) do
			changeset
			|> put_change(:code, code |> String.upcase |> String.replace(" ", "-"))
		else
			changeset
		end
	end
end
