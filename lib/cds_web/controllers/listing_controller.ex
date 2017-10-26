defmodule CdsWeb.ListingController do
	use CdsWeb, :controller
	alias Cds.Listings
	alias Cds.Listings.Business

	plug :load_categories when action in [:new, :create]
	plug :track_views

	def index(conn, _) do
		listings = Listings.get_listings
		render conn, "index.html", listings: listings
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
		Cds.TrackListingView.track(remote_ip)
		conn
	end
end
