defmodule CdsWeb.CategoryController do
	use CdsWeb, :controller
	alias Cds.Listings
	alias Cds.Listings.Category

	def index(conn, _) do
		render conn, "index.html"
	end

	def new(conn, _) do
		changeset = Category.changeset(%Category{}, %{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"category" => category_params}) do
		case Listings.create_category(category_params) do
			{:ok, category} ->
				conn
				|> put_flash(:info, "Category successfully.")
				|> redirect(to: category_path(conn, :index))
			{:error, changeset} ->
				render(conn, "new.html", changeset: changeset)
	    end
	end
end
