defmodule CdsWeb.SessionController do
	use CdsWeb, :controller

	def new(conn, _params) do
		render conn, "new.html"
	end
end
