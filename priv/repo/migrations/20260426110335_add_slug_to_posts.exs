defmodule Jamie.Repo.Migrations.AddSlugToPosts do
  use Ecto.Migration

  def change do
    alter table(:blog_posts) do
      add :slug, :string, index: true
    end

    create unique_index(:blog_posts, [:slug])
  end
end
