defmodule JamieWeb.SitemapXML do
  @moduledoc false

  def render(posts, base_url) do
    urls = Enum.map_join(posts, "\n", &url_xml(&1, base_url))

    """
    <?xml version="1.0" encoding="utf-8"?>
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
      <url>
        <loc>#{base_url}/</loc>
      </url>
    #{urls}
    </urlset>
    """
  end

  defp url_xml(post, base_url) do
    lastmod = post.edited_on || post.published_on

    """
      <url>
        <loc>#{base_url}/posts/#{post.slug}</loc>
        <lastmod>#{Date.to_iso8601(lastmod)}</lastmod>
      </url>
    """
  end
end
