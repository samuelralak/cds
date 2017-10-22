defmodule Cds.Accounts.User do
	use Ecto.Schema
	import Ecto.Changeset
	alias Cds.Accounts.User

	schema "users" do
		field :first_name, :string
		field :last_name, :string
		field :password_digest, :string
		field :role_id, :id

		timestamps()
	end

	@doc false
	def changeset(%User{} = user, attrs) do
		user
		|> cast(attrs, [:first_name, :last_name, :password_digest])
		|> validate_required([:first_name, :last_name, :password_digest])
	end
end
