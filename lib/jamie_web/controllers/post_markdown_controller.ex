defmodule JamieWeb.PostMarkdownController do
  use JamieWeb, :controller

  alias Jamie.Blog

  def show(conn, %{"slug" => slug}) do
    post = Blog.get_post_by_slug!(slug)
    body = front_matter(post) <> (post.markdown || "")

    conn
    |> put_resp_content_type("text/markdown")
    |> put_resp_header("cache-control", "public, max-age=3600")
    |> send_resp(200, body)
  end

  defp front_matter(post) do
    """
    ---
    title: #{post.title}
    description: #{post.description}
    published_on: #{post.published_on}
    edited_on: #{post.edited_on}
    url: #{JamieWeb.Endpoint.url()}/posts/#{post.slug}
    author: Jamie Curle
    copyright: Copyright Jamie Curle. All rights reserved.
    license: Reading and summarising permitted. Reproduction and AI training prohibited.
    ---

    """
  end
end
