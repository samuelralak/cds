defmodule Cds.Listings do
	@moduledoc """
	The listings context
	"""

	import Ecto.Query, warn: false
    alias Cds.Repo
    alias Cds.Listings.Category

	def create_category(attrs \\ %{}) do
		%Category{}
		|> Category.changeset(attrs)
		|> Repo.insert
    end
end
