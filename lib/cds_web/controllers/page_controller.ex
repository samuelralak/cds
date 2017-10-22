defmodule CdsWeb.PageController do
  use CdsWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
