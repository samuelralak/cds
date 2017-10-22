defmodule Cds.Accounts.User do
	use Ecto.Schema

	import Ecto.Changeset
	import Comeonin.Bcrypt, only: [hashpwsalt: 1]

	alias Cds.Accounts.User

	schema "users" do
		field :first_name, :string
		field :last_name, :string
		field :email, :string
		field :password_digest, :string
		belongs_to :role, Cds.Accounts.Role

		# virtual fields
		field :password, :string, virtual: true
		field :password_confirmation, :string, virtual: true

		timestamps()
	end

	@default_fields [:first_name, :last_name, :email, :password, :password_confirmation]
	@required [:email, :password, :password_confirmation]

	@doc false
	def changeset(%User{} = user, attrs) do
		user
		|> cast(attrs, @default_fields)
		|> validate_required(@required)
		|> unique_constraint(:email)
		|> validate_format(:email, ~r/@/)
	end

	def create_changeset(user, attrs) do
		user
		|> changeset(attrs)
		|> validate_confirmation(:password, message: "does not match password!")
		|> hash_password
	end

	defp hash_password(changeset) do
		if password = get_change(changeset, :password) do
			put_change(changeset, :password_digest, hashpwsalt(password))
		else
			changeset
		end
	end
end
