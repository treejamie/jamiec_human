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

Enum.each(1..288, fn x ->
  # simulate six posts a month from now backwards

  # 6 a months 6 * 12 == 72
  year = NaiveDateTime.utc_now().year - div(x, 72)

  # this gives us a month
  month = rem(x, 12) + 1

  # now make the published day as a random
  # staggered dates is fine as I could start a post and finish it after I'd
  # started and finisehed another one.
  day = 1..Date.days_in_month(Date.new!(year, month, 1)) |> Enum.random()

  # some posts will be edited - 25% chance

  edited_on =
    (Enum.map(1..4, fn _ -> nil end) ++
       [Date.add(Date.new!(year, month, day), 3)])
    |> Enum.random()

  # attrs
  attrs =
    %{
      title: Enum.take_random(words, Enum.random(4..15)) |> Enum.join(" ") |> String.capitalize(),
      status: Enum.random([:published, :published, :draft, :hidden, :published]),
      description:
        Enum.take_random(words, Enum.random(20..45)) |> Enum.join(" ") |> String.capitalize(),
      markdown: post_content,
      published_on: Date.new!(year, month, day),
      edited_on: edited_on
    }

  # Here is to your health
  # I'm not Homeboy Sandman, I am someone else
  # Who turned the corner cuz the New World Order needed help
  # Who’s known to make it so that frozen water doesn't melt
  # Born again, fostering the knowledge of the self
  # Like everyone in Boston has the knowledge of the Celts
  # Kicking in your door, but on the low like I'm an elf
  # Now I’m in your house, reading every book that's on your shelf
  # HIT IT!
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
