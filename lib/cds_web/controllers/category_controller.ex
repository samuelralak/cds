defmodule CdsWeb.CategoryController do
	use CdsWeb, :controller
	alias Cds.Listings
	alias Cds.Listings.Category

	def index(conn, _) do
		categories = Listings.list_categories
		render conn, "index.html", categories: categories
	end

	def new(conn, _) do
		changeset = Category.changeset(%Category{}, %{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"category" => category_params}) do
		case Listings.create_category(category_params) do
			{:ok, _category} ->
				conn
				|> put_flash(:info, "Category successfully.")
				|> redirect(to: category_path(conn, :index))
			{:error, changeset} ->
				render(conn, "new.html", changeset: changeset)
	    end
	end

	def edit(conn, %{"id" => id}) do
		category = Listings.get_category!(id)
	    changeset = Category.changeset(category, %{})
	    render(conn, "edit.html", category: category, changeset: changeset)
	end

	def update(conn, %{"id" => id, "category" => category_params}) do
		category = Listings.get_category!(id)

		case Listings.update_category(category, category_params) do
			{:ok, _category} ->
				conn
				|> put_flash(:info, "Category updated successfully.")
				|> redirect(to: category_path(conn, :index))
			{:error, %Ecto.Changeset{} = changeset} ->
				render(conn, "edit.html", category: category, changeset: changeset)
      end
    end
end
