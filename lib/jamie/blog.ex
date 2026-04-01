defmodule Jamie.Blog do
  alias Jamie.Repo
  alias Jamie.Blog.Post

  def create_post(attrs) do
    case Post.changeset(%Post{}, attrs) do
      %{valid?: true} = changeset -> Repo.insert(changeset)
      changeset -> changeset
    end
  end
end
