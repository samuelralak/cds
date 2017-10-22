# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#


import Ecto.Query

alias Cds.Repo
alias Cds.Accounts.Role
alias Cds.Accounts.User

roles = ["admin", "moderator", "member"]
Enum.map(roles, fn role ->
    case Repo.all(from r in Role, where: r.code == ^String.upcase(role)) do
        [] ->
            %Role{}
            |> Role.changeset(%{name: role, code: String.upcase(role), is_active: true})
            |> Repo.insert!()
        _ ->
            IO.puts "Role: #{role} already exists"
    end
end)

admin = Repo.get_by!(Role, code: "ADMIN")
attrs = %{email: "admin@cds.com", password: "123456",  password_confirmation: "123456"}
unless Repo.get_by(User, email: attrs.email) do
	admin
	|> Ecto.build_assoc(:users)
	|> User.create_changeset(attrs)
	|> Repo.insert!
end
