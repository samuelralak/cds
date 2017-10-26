defmodule Cds.TrackListingView do
	use GenServer
	import Ecto.Query

	alias Cds.Repo
	alias Cds.Listings
	alias Cds.Listings.View
	alias Cds.Listings.Business

	@name TLV

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, :ok, opts ++ [name: TLV])
	end

	def init(:ok), do: {:ok, %{}}

	def track({ip, id}) do
		GenServer.cast(@name, {:track, {ip, id}})
	end

	def handle_cast({:track, {ip, id}}, state) do
		case Repo.all(from v in View, where: v.ip_address == ^ip) do
			[] ->
				listing = Repo.get!(Business, String.to_integer(id))
				case create_view(listing, %{ip_address: ip}) do
					{:ok, _view} ->
						update_view_count(listing)
					{:error, changeset} ->
						IO.inspect changeset
				end

			_ ->
				IO.inspect "View from this IP already tracked"
		end
		{:noreply, state}
	end

	defp create_view(listing, attrs) do
		listing
		|> Ecto.build_assoc(:views)
		|> View.changeset(attrs)
		|> Repo.insert
	end

	defp update_view_count(listing) do
		count =
			View
			|> where(business_id: ^listing.id)
			|> Repo.aggregate(:count, :id)
		IO.inspect count
		IO.inspect Listings.update_listing(listing, %{view_count: count})
	end
end
