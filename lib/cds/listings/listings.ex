defmodule Cds.Listings do
	@moduledoc """
	The listings context
	"""

	import Ecto.Query, warn: false
    alias Cds.Repo
    alias Cds.Listings.Category

	def get_category!(id) do
		Repo.get!(Category, id)
	end

	def list_categories do
		Repo.all(Category)
	end

	def create_category(attrs \\ %{}) do
		%Category{}
		|> Category.changeset(attrs)
		|> Repo.insert
    end

	def update_category(category, attrs) do
		category
		|> Category.changeset(attrs)
		|> Repo.update
	end
end
