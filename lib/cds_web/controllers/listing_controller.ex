defmodule CdsWeb.ListingController do
	use CdsWeb, :controller
	alias Cds.Listings
	alias Cds.Listings.Business

	plug :load_categories when action in [:new, :create, :edit]
	plug :track_views when action in [:show]

	def index(conn, _) do
		listings = Listings.get_listings
		render conn, "index.html", listings: listings
	end

	def show(conn, %{"id" => id}) do
		listing = Listings.get_listing!(id)
		render conn, "show.html", listing: listing
	end

	def new(conn, _) do
		changeset = Business.changeset(%Business{}, %{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"business" => business_params}) do
		case Listings.create_business(business_params) do
			{:ok, _business} ->
				conn
				|> put_flash(:info, "Listing added successfully.")
				|> redirect(to: listing_path(conn, :index))
			{:error, changeset} ->
				render(conn, "new.html", changeset: changeset)
		end
	end

	def edit(conn, %{"id" => id}) do
		listing = Listings.get_listing!(id)
	    changeset = Business.update_changeset(listing, %{})
		IO.inspect changeset
		render conn, "edit.html", changeset: changeset, listing: listing
	end

	def update(conn, %{"id" => id, "business" => business_params}) do
		listing = Listings.get_listing!(id)

		case Listings.update_listing(listing, business_params) do
			{:ok, _business} ->
				conn
				|> put_flash(:info, "Listing updated successfully.")
				|> redirect(to: listing_path(conn, :index))
			{:error, %Ecto.Changeset{} = changeset} ->
				render(conn, "edit.html", listing: listing, changeset: changeset)
		end
    end

	def delete(conn, %{"id" => id}) do
		listing = Listings.get_listing!(id)
		Listings.delete_listing(listing)

		conn
		|> put_flash(:info, "Listing deleted successfully.")
		|> redirect(to: listing_path(conn, :index))
	end

	def search(conn, %{"search" => %{"query" => query}}) do
		results = Listings.search(query)
		render conn, "search.html", results: results, query: query
	end

	defp load_categories(conn, _) do
		categories = Listings.load_categories
		assign(conn, :categories, categories)
	end

	defp track_views(conn, _) do
		remote_ip = to_string(:inet_parse.ntoa(conn.remote_ip))
		Cds.TrackListingView.track({remote_ip, conn.params["id"]})
		conn
	end
end
