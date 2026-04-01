defmodule Jamie.Blog.Test do
  use Jamie.DataCase, async: true

  alias Jamie.Support.BlogFixtures
  alias Jamie.Blog
  alias Jamie.Repo

  describe "create_post/1" do
    test "posts create with required fields" do
      # there are no blog posts
      assert 0 == Repo.aggregate(Jamie.Blog.Post, :count)

      # now make one
      attrs = BlogFixtures.blog_attrs()
      Blog.create_post(attrs)

      # now there is one
      assert 1 == Repo.aggregate(Jamie.Blog.Post, :count)
    end

    test "all fields need to be present in order to save" do
      # blank map
      attrs = %{}
      cs = %Ecto.Changeset{valid?: false} = Blog.create_post(attrs)

      # three errors
      assert Keyword.has_key?(cs.errors, :title)
      assert Keyword.has_key?(cs.errors, :description)
      assert Keyword.has_key?(cs.errors, :markdown)

      # add in title
      attrs = Map.put(attrs, :title, "Done")
      cs = %Ecto.Changeset{valid?: false} = Blog.create_post(attrs)

      # two errors
      assert Keyword.has_key?(cs.errors, :description)
      assert Keyword.has_key?(cs.errors, :markdown)

      # add in description
      attrs = Map.put(attrs, :description, "Done")
      cs = %Ecto.Changeset{valid?: false} = Blog.create_post(attrs)

      # two errors
      assert Keyword.has_key?(cs.errors, :markdown)

      # add in markdown - valid
      attrs = Map.put(attrs, :markdown, "Done")
      {:ok, %Blog.Post{}} = Blog.create_post(attrs)
    end

    test "html is generated when the post saves" do
      # now make one
      attrs = BlogFixtures.blog_attrs(markdown: "# Hello")
      {:ok, post} = Blog.create_post(attrs)

      # it's present when returned
      assert post.html ==
               "<h1><a href=\"#hello\" aria-hidden=\"true\" class=\"anchor\" id=\"hello\"></a>Hello</h1>"

      # and it's persisted into the database
      post = Jamie.Repo.get(Blog.Post, post.id)

      assert post.html ==
               "<h1><a href=\"#hello\" aria-hidden=\"true\" class=\"anchor\" id=\"hello\"></a>Hello</h1>"
    end
  end
end
