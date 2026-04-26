defmodule JamieWeb.BlogLive.Post do
  use JamieWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _url, socket) do
    socket =
      socket
      |> assign(:post, Jamie.Blog.get_post!(slug))

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <h1>{@post.title}</h1>
      <p>
        {raw(@post.html)}
      </p>
    </Layouts.app>
    """
  end
end
