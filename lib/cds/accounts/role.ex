defmodule Cds.Accounts.Role do
	use Ecto.Schema
	import Ecto.Changeset
	alias Cds.Accounts.Role

	schema "roles" do
		field :code, :string
		field :is_active, :boolean, default: false
		field :name, :string

		timestamps()
	end

	@doc false
	def changeset(%Role{} = role, attrs) do
		role
		|> cast(attrs, [:name, :code, :is_active])
		|> validate_required([:name, :code, :is_active])
	end
end
