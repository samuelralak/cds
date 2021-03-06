defmodule Cds.Listings do
	@moduledoc """
	The listings context
	"""

	import Ecto.Query, warn: false
    alias Cds.Repo
    alias Cds.Listings.Category
	alias Cds.Listings.Business

	def get_listings do
		Business
		|> preload(:categories)
		|> Repo.all
	end

	def get_category!(id) do
		Repo.get!(Category, id)
	end

	def get_listing!(id) do
		Business
		|> preload(:categories)
		|> Repo.get!(id)
	end

	def list_categories do
		Repo.all(Category)
	end

	def load_categories do
		Category
		|> Category.alphabetical
		|> Category.names_and_ids
		|> Repo.all
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

	def update_listing(business, attrs) do
		business
		|> Business.update_changeset(attrs)
		|> Repo.update
	end

	def delete_category(category) do
		Repo.delete(category)
	end

	def delete_listing(business) do
		Repo.delete(business)
	end

	def create_business(attrs) do
		%Business{}
		|> Business.changeset(attrs)
		|> Repo.insert
	end

	def search(term) do
		formatted = term |> String.replace(" ", "|")
		Repo.execute_and_load(
			"SELECT * FROM businesses WHERE id IN (
				SELECT searchable_id FROM searches
				WHERE to_tsvector('english', term) @@ to_tsquery($1));
			", [ formatted ], Business)
	end
end
