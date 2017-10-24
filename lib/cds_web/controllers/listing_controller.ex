defmodule CdsWeb.ListingController do
	use CdsWeb, :controller

	def new(conn, _) do
		render conn, "new.html"
	end
end
