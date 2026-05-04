defmodule JamieWeb.BlogLive.Index do
  use JamieWeb, :live_view

  @months ~w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    archive = Jamie.Blog.published_posts() |> group_archive()

    socket =
      socket
      |> assign(:archive, archive)

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="archive">
        <h1>The Archive</h1>
        <section :for={{year, months} <- @archive} class="archive-year">
          <h2 class="archive-year-label">{year}</h2>
          <div class="archive-year-months">
            <section :for={{month, posts} <- months} class="archive-month">
              <h3 class="archive-month-label">{month_name(month)}</h3>
              <ul class="archive-posts">
                <li :for={post <- posts} class="post-card">
                  <.link href={~p"/posts/#{post.slug}"}>{post.title}</.link>
                </li>
              </ul>
            </section>
          </div>
        </section>
      </div>
    </Layouts.app>
    """
  end

  defp group_archive(posts) do
    posts
    |> Enum.group_by(& &1.published_on.year)
    |> Enum.sort_by(fn {year, _} -> year end, :desc)
    |> Enum.map(fn {year, year_posts} ->
      months =
        year_posts
        |> Enum.group_by(& &1.published_on.month)
        |> Enum.sort_by(fn {month, _} -> month end, :desc)

      {year, months}
    end)
  end

  defp month_name(n), do: Enum.at(@months, n - 1)
end
