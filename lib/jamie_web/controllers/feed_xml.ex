defmodule JamieWeb.FeedXML do
  @moduledoc false
  def render(posts, base_url) do
    updated =
      case List.first(posts) do
        nil -> DateTime.to_iso8601(DateTime.utc_now())
        post -> to_rfc3339(post.edited_on || post.published_on)
      end

    entries = Enum.map_join(posts, "\n", &entry_xml(&1, base_url))

    """
    <?xml version="1.0" encoding="utf-8"?>
    <feed xmlns="http://www.w3.org/2005/Atom">
      <title>Jamie Curle</title>
      <link href="#{base_url}/" />
      <link rel="self" type="application/atom+xml" href="#{base_url}/feed.xml" />
      <id>#{base_url}/</id>
      <updated>#{updated}</updated>
      <author>
        <name>Jamie Curle</name>
      </author>
    #{entries}
    </feed>
    """
  end

  defp entry_xml(post, base_url) do
    updated = post.edited_on || post.published_on

    """
      <entry>
        <title>#{escape(post.title)}</title>
        <link href="#{base_url}/posts/#{post.slug}" />
        <id>#{base_url}/posts/#{post.slug}</id>
        <published>#{to_rfc3339(post.published_on)}</published>
        <updated>#{to_rfc3339(updated)}</updated>
        <summary>#{escape(post.description)}</summary>
        <content type="html">#{escape(post.html)}</content>
      </entry>
    """
  end

  defp escape(value), do: Plug.HTML.html_escape(value)

  defp to_rfc3339(%Date{} = date) do
    DateTime.new!(date, ~T[00:00:00], "Etc/UTC") |> DateTime.to_iso8601()
  end
end
