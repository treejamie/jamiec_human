defmodule JamieWeb.Plugs.LinkHeaders do
  @moduledoc """
  Adds an RFC 8288 `Link` header pointing AI agents at key
  discovery resources on the site (feed, sitemap, llms.txt,
  agent skills index).
  """

  @behaviour Plug

  @links [
    {"/feed.xml", ~s(rel="alternate"; type="application/atom+xml")},
    {"/sitemap.xml", ~s(rel="sitemap")},
    {"/llms.txt", ~s(rel="describedby")},
    {"/.well-known/agent-skills/index.json", ~s(rel="agent-skills")}
  ]

  @header_value @links
                |> Enum.map_join(", ", fn {path, params} -> "<#{path}>; #{params}" end)

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, _opts) do
    Plug.Conn.put_resp_header(conn, "link", @header_value)
  end
end
