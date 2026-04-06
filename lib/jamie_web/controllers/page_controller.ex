defmodule JamieWeb.PageController do
  use JamieWeb, :controller

  def health(conn, _params) do
    conn
    |> put_root_layout(html: false)
    |> render(:health)
  end
end
