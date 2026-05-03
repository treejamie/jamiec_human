#
# posts
#
alias Jamie.Blog.Post

[
  %{
    title: "Test Post with all the Elements",
    status: :published,
    description:
      "Elixir's pattern matching feature is introduced through practical code examples covering tuples, lists, and the pin operator. The post explains when pattern matching is most useful — in function heads, case expressions, and unpacking results — and includes a quick reference table of common syntax. It closes with pointers to further reading and a teaser for a follow-up post on with pipelines.",
    markdown: File.read!("priv/repo/post.md")
  }
]
|> Enum.each(fn attrs ->
  Post.changeset(%Post{}, attrs)
  |> Jamie.Repo.insert(on_conflict: :nothing, conflict_target: :slug)
end)

#
# now do users
#
alias Jamie.Accounts.User
d = "2026-04-01 00:00:00"

[%{email: "foo@bar.com", confirmed_at: d, inserted_at: d, updated_at: d}]
|> Enum.each(fn attrs ->
  User.seed_changeset(%User{}, attrs)
  |> Jamie.Repo.insert(on_conflict: :nothing, conflict_target: :email)
end)

#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
