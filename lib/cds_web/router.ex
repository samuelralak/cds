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

		get "/", PageController, :index
		get "/login", SessionController, :new
		post "/login", SessionController, :create
	end

	# Other scopes may use custom stacks.
	# scope "/api", CdsWeb do
	#   pipe_through :api
	# end
end
