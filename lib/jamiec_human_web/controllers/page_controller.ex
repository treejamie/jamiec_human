defmodule JamiecHumanWeb.PageController do
  use JamiecHumanWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
