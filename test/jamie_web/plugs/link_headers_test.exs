defmodule JamieWeb.Plugs.LinkHeadersTest do
  use JamieWeb.ConnCase, async: true

  alias JamieWeb.Plugs.LinkHeaders

  describe "call/2" do
    test "sets exactly one link header" do
      conn =
        build_conn(:get, "/")
        |> LinkHeaders.call(LinkHeaders.init([]))

      assert [_one] = get_resp_header(conn, "link")
    end

    test "header value contains all four discovery relations" do
      conn =
        build_conn(:get, "/")
        |> LinkHeaders.call(LinkHeaders.init([]))

      [link] = get_resp_header(conn, "link")

      assert link =~ ~s(</feed.xml>; rel="alternate"; type="application/atom+xml")
      assert link =~ ~s(</sitemap.xml>; rel="sitemap")
      assert link =~ ~s(</llms.txt>; rel="describedby")
      assert link =~ ~s(</.well-known/agent-skills/index.json>; rel="agent-skills")
    end

    test "relations are comma-separated per RFC 8288" do
      conn =
        build_conn(:get, "/")
        |> LinkHeaders.call(LinkHeaders.init([]))

      [link] = get_resp_header(conn, "link")

      assert length(String.split(link, ", ")) == 4
    end

    test "does not modify the response status or body" do
      conn = build_conn(:get, "/")

      after_conn = LinkHeaders.call(conn, LinkHeaders.init([]))

      assert after_conn.status == conn.status
      assert after_conn.resp_body == conn.resp_body
    end
  end

  describe "integration with the :browser pipeline" do
    test "browser responses include the link header", %{conn: conn} do
      conn = get(conn, ~p"/")

      assert [link] = get_resp_header(conn, "link")
      assert link =~ ~s(rel="agent-skills")
      assert link =~ ~s(rel="sitemap")
    end

    test "header is identical across different browser routes", %{conn: conn} do
      [from_root] = conn |> get(~p"/") |> get_resp_header("link")
      [from_health] = build_conn() |> get(~p"/health") |> get_resp_header("link")

      assert from_root == from_health
    end
  end
end
