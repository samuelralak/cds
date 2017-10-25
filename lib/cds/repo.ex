defmodule Cds.Repo do
	use Ecto.Repo, otp_app: :cds

	@doc """
	Dynamically loads the repository url from the
	DATABASE_URL environment variable.
	"""
	def init(_, opts) do
		{:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
	end

	def execute_and_load(sql, params, model) do
		Ecto.Adapters.SQL.query!(__MODULE__, sql, params) |> load_into(model)
	end

	defp load_into(response, model) do
		Enum.map(response.rows, fn row ->
			fields = Enum.reduce(Enum.zip(response.columns, row), %{}, fn({key, value}, map) ->
				Map.put(map, key, value)
			end)
			load(model, fields)
		end)
	end
end
