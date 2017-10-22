# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#


import Ecto.Query

alias Cds.Repo
alias Cds.Accounts.Role

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
