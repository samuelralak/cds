defmodule CdsWeb.Router do
	use CdsWeb, :router

	pipeline :browser do
		plug :accepts, ["html"]
		plug :fetch_session
		plug :fetch_flash
		plug :protect_from_forgery
		plug :put_secure_browser_headers
		plug Guardian.Plug.VerifySession # looks in the session for the token
        plug Guardian.Plug.LoadResource
	end

	pipeline :authenticate_user do
		plug Guardian.Plug.EnsureResource, handler: Cds.AuthErrorHandler
	end

	pipeline :authorize_user do
		plug Guardian.Plug.EnsurePermissions, handler: Cds.AuthErrorHandler, admin: [:read, :write, :manage]
	end

	pipeline :api do
		plug :accepts, ["json"]
	end

	scope "/", CdsWeb do
		pipe_through :browser # Use the default browser stack

		get "/", ListingController, :index

		# session routes
		get    "/login", SessionController, :new
		post   "/login", SessionController, :create
		delete "/logout", SessionController, :delete

		# listings routes
		resources "/listings", ListingController, only: [:index, :show]

		# Search path
		get "/search", ListingController, :search
	end

	scope "/admin", CdsWeb do
		pipe_through [:browser, :authenticate_user, :authorize_user]

		resources "/categories", CategoryController, except: [:show, :delete]
		resources "/listings", ListingController, except: [:index, :show]
	end

	scope "/api", CdsWeb do
		pipe_through :api
		get "/search", SearchController,  :index
	end
end
