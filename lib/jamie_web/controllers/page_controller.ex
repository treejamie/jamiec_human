defmodule JamieWeb.PageController do
  use JamieWeb, :controller

  def health(conn, _params) do
    render(conn, :health)
  end
end
