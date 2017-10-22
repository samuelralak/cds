defmodule CdsWeb.SessionController do
	use CdsWeb, :controller
	alias Cds.Accounts.User

	def new(conn, _params) do
		changeset = User.changeset(%User{}, %{})
		render conn, "new.html", changeset: changeset
	end
end
