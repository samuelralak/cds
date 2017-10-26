defmodule Cds.AuthErrorHandler do
	import CdsWeb.Router.Helpers

	def no_resource(conn, _params) do
		conn
		|> Phoenix.Controller.put_flash(:error, "You must be logged in.")
		|> Phoenix.Controller.redirect(to: session_path(conn, :new))
	end

	def unauthenticated(conn, _params) do
		conn
		|> Phoenix.Controller.put_flash(:error, "You must be logged in.")
		|> Phoenix.Controller.redirect(to: session_path(conn, :new))
	end

	def unauthorized(conn, _params) do
		conn
		|> Phoenix.Controller.put_flash(:error, "You must be authorised.")
		|> Phoenix.Controller.redirect(to: session_path(conn, :new))
	end
end
