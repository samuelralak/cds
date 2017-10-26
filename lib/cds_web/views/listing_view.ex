defmodule CdsWeb.ListingView do
	use CdsWeb, :view

	def selected(listing) do
		if !is_nil(listing) && listing.categories != [] do
			Enum.map(listing.categories, fn(x) -> x.id end)
		end
	end
end
