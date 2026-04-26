# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:

alias Jamie.Blog.Post

posts = [
  %{
    title: "A blog post",
    status: :published,
    description: " a description of the blog post",
    markdown:
      "# My First Post\n\nThis is a short introduction paragraph with some **bold** and *italic* text.\n\n## A Subheading\n\nHere's a list of things:\n\n- Item one\n- Item two\n- Item three\n\nAnd a bit of `inline code` for good measure."
  }
]

posts

Enum.each(posts, fn attrs ->
  Post.changeset(%Post{}, attrs)
  |> Jamie.Repo.insert(on_conflict: :nothing, conflict_target: :slug)
end)

#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
