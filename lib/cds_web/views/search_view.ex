defmodule CdsWeb.SearchView do
	use CdsWeb, :view

	def render("index.json", %{results: results, query: query}) do
		%{
			query: query,
			data: render_results(results)
		}
	end

	defp render_results(results) do
		for result <- results  do
			%{
				id: result.id,
				name: result.name,
				description: result.description,
				email: result.email,
				phone_number: result.phone_number,
				address: result.address,
				website_url: result.website_url
			}
		end
	end
end
