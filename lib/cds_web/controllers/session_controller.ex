defmodule CdsWeb.SessionController do
	use CdsWeb, :controller
	alias Cds.Accounts.User
	alias Cds.Session
	alias Cds.Accounts.Role

	def new(conn, _params) do
		changeset = User.changeset(%User{}, %{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"user" =>  %{"email" => email, "password" => password}}) do
		case Session.login_by_email_and_pass(email, password) do
			{:ok, user} ->
				conn
				|> attach_perms(user)
                |> put_flash(:info, "Sign in successful!")
                |> redirect(to: listing_path(conn, :index))
			{:error, _} ->
				conn
				|> put_flash(:error, "Invalid login details!")
				|> redirect(to: session_path(conn, :new))
		end
	end

	def delete(conn, _params) do
        Guardian.Plug.sign_out(conn)
        |> put_flash(:info, "Signed out successfully!")
        |> redirect(to: session_path(conn, :new))
    end

	defp attach_perms(conn, user) do
		case Cds.Repo.get!(Role, user.role_id).code do
			"ADMIN" ->
				Guardian.Plug.sign_in(conn, user, :access, perms: %{ admin: [:read, :write, :manage] })
			_ ->
				Guardian.Plug.sign_in(conn, user)
		end
	end
end
