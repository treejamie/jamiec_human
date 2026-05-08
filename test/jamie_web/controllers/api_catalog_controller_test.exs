defmodule JamieWeb.ApiCatalogControllerTest do
  use JamieWeb.ConnCase, async: true

  describe "GET /.well-known/api-catalog" do
    test "returns 200", %{conn: conn} do
      conn = get(conn, ~p"/.well-known/api-catalog")
      assert conn.status == 200
    end

    test "responds with application/linkset+json content type", %{conn: conn} do
      conn = get(conn, ~p"/.well-known/api-catalog")

      assert [content_type] = get_resp_header(conn, "content-type")
      assert content_type =~ "application/linkset+json"
    end

    test "body is valid JSON", %{conn: conn} do
      body = conn |> get(~p"/.well-known/api-catalog") |> response(200)
      assert {:ok, _decoded} = Jason.decode(body)
    end

    test "body contains a linkset key", %{conn: conn} do
      body = conn |> get(~p"/.well-known/api-catalog") |> response(200)
      decoded = Jason.decode!(body)

      assert Map.has_key?(decoded, "linkset")
    end

    test "linkset value is an empty array", %{conn: conn} do
      body = conn |> get(~p"/.well-known/api-catalog") |> response(200)
      decoded = Jason.decode!(body)

      assert decoded["linkset"] == []
    end
  end
end
