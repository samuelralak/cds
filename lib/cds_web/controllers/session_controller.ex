defmodule CdsWeb.SessionController do
	use CdsWeb, :controller
	alias Cds.Accounts.User
	alias Cds.Session

	def new(conn, _params) do
		changeset = User.changeset(%User{}, %{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"user" =>  %{"email" => email, "password" => password}}) do
		case Session.login_by_email_and_pass(email, password) do
			{:ok, _user} ->
				conn
                |> put_flash(:info, "Sign in successful!")
                |> redirect(to: page_path(conn, :index))
			{:error, _} ->
				conn
				|> put_flash(:error, "Invalid login details!")
				|> redirect(to: session_path(conn, :new))
		end
	end
end
