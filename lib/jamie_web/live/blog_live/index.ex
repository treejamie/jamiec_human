defmodule JamieWeb.BlogLive.Index do
  use JamieWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    Blog Index
    """
  end
end
