defmodule Cds.Session do
	@moduledoc """
	The session context
	"""
	import Ecto.Query, warn: false
	import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

    alias Cds.Repo
	alias Cds.Accounts.User

	def login_by_email_and_pass(email, given_pass) do
		user = Repo.get_by(User, email: email)

		cond do
			user && checkpw(given_pass, user.password_digest) ->
				{:ok, user}
			user ->
                {:error, :unauthorized}
            true ->
				dummy_checkpw()
				{:error, :not_found}
		end
	end
end
