defmodule JamieWeb.BlogComponents do
  @moduledoc """
  Blog components for the web layer.
  """
  use Phoenix.Component
  attr :content, :string, required: true

  def reading_time(assigns) do
    words =
      assigns.content
      |> String.split(~r/\s+/, trim: true)
      |> length()

    minutes = max(1, ceil(words / 200))

    assigns = assign(assigns, :minutes, minutes)

    ~H"""
    <span>{@minutes} min read</span>
    """
  end
end
