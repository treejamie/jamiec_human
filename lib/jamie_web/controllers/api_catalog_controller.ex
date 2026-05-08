defmodule JamieWeb.ApiCatalogController do
  use JamieWeb, :controller

  @body Jason.encode!(%{linkset: []})

  def index(conn, _params) do
    conn
    |> put_resp_content_type("application/linkset+json")
    |> send_resp(200, @body)
  end
end
