defmodule CdsWeb.SearchController do
	use CdsWeb, :controller
	alias Cds.Listings

	def index(conn, %{ "query" => query }) do
		results = Listings.search(query)
		render conn, "index.json", results: results, query: query
	end
end
