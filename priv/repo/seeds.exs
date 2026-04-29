#
# posts
#
alias Jamie.Blog.Post

[
  %{
    title: "A nice title of a sufficient length",
    status: :published,
    description:
      "Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas.",
    markdown:
      "My First Post\n\nThis is a short introduction paragraph with some **bold** and *italic* text.\n\n## A Subheading\n\nHere's a list of things:\n\n- Item one\n- Item two\n- Item three\n\nAnd a bit of `inline code` for good measure."
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
