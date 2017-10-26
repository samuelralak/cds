defmodule CdsWeb.Router do
	use CdsWeb, :router

	pipeline :browser do
		plug :accepts, ["html"]
		plug :fetch_session
		plug :fetch_flash
		plug :protect_from_forgery
		plug :put_secure_browser_headers
	end

	pipeline :api do
		plug :accepts, ["json"]
	end

	scope "/", CdsWeb do
		pipe_through :browser # Use the default browser stack

		get "/", ListingController, :index

		# session routes
		get  "/login", SessionController, :new
		post "/login", SessionController, :create

		# categories routes
		resources "/categories", CategoryController, except: [:show]

		# listings routes
		resources "/listings", ListingController, except: [:index]

		# Search path
		get "/search", ListingController, :search
	end

	scope "/api", CdsWeb do
		pipe_through :api
		get "/search", SearchController,  :index
	end
end
