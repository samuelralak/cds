defmodule Cds.TrackListingView do
	use GenServer

	@name TLV

	def start_link(opts \\ []) do
		GenServer.start_link(__MODULE__, :ok, opts ++ [name: TLV])
	end

	def init(:ok), do: {:ok, %{}}

	def track(ip) do
		GenServer.cast(@name, {:track, ip})
	end

	def handle_cast({:track, ip}, state) do
		IO.inspect "\n\n TRACKING VIEW FROM #{ip} \n\n"
		{:noreply, state}
	end
end
