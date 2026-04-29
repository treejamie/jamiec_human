defmodule Jamie.Blog do
  @moduledoc """
  The blog context boundary.
  """

  alias Jamie.Blog.Post
  alias Jamie.Repo
  import Ecto.Query

  @doc """
  returns a changeset for a post
  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  @doc """
  Creates a post
  """
  def create_post(attrs) do
    case Post.changeset(%Post{}, attrs) do
      %{valid?: true} = changeset -> Repo.insert(changeset)
      changeset -> changeset
    end
  end

  @doc """
  Gets a post by slug
  """
  def get_post_by_slug!(slug) do
    Post
    |> Repo.get_by!(slug: slug)
  end

  @doc """
  Gets a post by id
  """
  def get_post!(id) do
    Post
    |> Repo.get!(id)
  end

  @doc """
  Updates a post
  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Gets published posts
  """
  def published_posts do
    from(p in Post, where: p.status == :published)
    |> Repo.all()
  end
end
