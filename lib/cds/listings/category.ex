defmodule Cds.Listings.Category do
	use Ecto.Schema
	import Ecto.Changeset
	alias Cds.Listings.Category

	schema "categories" do
		field :code, :string
		field :is_active, :boolean, default: true
		field :name, :string

		timestamps()
	end

	@doc false
	def changeset(%Category{} = category, attrs) do
		category
		|> cast(attrs, [:name])
		|> validate_required([:name])
  end
end
