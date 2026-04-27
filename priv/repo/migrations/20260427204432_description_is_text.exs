defmodule Jamie.Repo.Migrations.DescriptionIsText do
  use Ecto.Migration

  def change do
    alter table(:blog_posts) do
      modify :description, :text
    end
  end
end
