defmodule JamieWeb.SiteComponents do
  @moduledoc """
  Site-wide components for the site
  """
  use Phoenix.Component

  @doc """
  A very crude home button
  """
  attr :current_path, :string, default: "/"

  def home(assigns) do
    ~H"""
    <%= if @current_path != "/" do %>
      <a href="/">
        &larr; HOME
      </a>
    <% end %>
    """
  end
end
