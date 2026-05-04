#
# posts
#
alias Jamie.Blog.Post

words = ~w(
  run jump swim fly climb crawl slide spin throw catch
  push pull lift drop kick punch grab release twist bend
  stretch fold cut break build destroy create write read draw
  paint sing dance play laugh cry whisper shout listen speak
  think dream sleep wake eat drink cook bake wash clean
  open close lock unlock start stop pause continue wait rush
  walk march skip hop dive sail drive ride carry drag
  hunt fish plant grow harvest dig pour mix stir shake
  mountain river ocean forest desert valley island volcano glacier cave
  dog cat horse elephant tiger eagle shark dolphin wolf bear
  apple mango peach grape lemon melon cherry plum pear fig
  table chair window door floor ceiling wall roof bridge tower
  sword shield arrow hammer axe spear bow dagger cannon lance
  cloud storm thunder lightning rain snow frost wind fog hail
  book map scroll letter journal poem song story legend myth
  king queen knight wizard dragon giant ghost witch elf dwarf
  fire water earth air shadow light darkness void spark flame
  ship boat cart wagon train plane rocket balloon raft canoe
  coin gem crystal pearl ruby sapphire emerald diamond gold silver
  clock mirror lantern compass telescope anchor bell drum flute horn
  city village castle dungeon temple market harbour farm mill forge
  friend enemy stranger merchant soldier farmer hunter healer thief scholar
  moon sun star comet nebula planet galaxy meteor aurora eclipse
  road path trail bridge gate tunnel stairs ladder fence wall
)

post_content = File.read!("priv/repo/post.md")

Enum.each(1..240, fn _x ->
  attrs = %{
    title: Enum.take_random(words, Enum.random(4..15)) |> Enum.join(" "),
    status: Enum.random([:published, :published, :draft, :hidden, :published]),
    description: Enum.take_random(words, Enum.random(20..45)) |> Enum.join(" "),
    markdown: post_content
  }

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
