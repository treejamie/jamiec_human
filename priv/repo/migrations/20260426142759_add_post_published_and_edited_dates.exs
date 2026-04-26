defmodule Jamie.Repo.Migrations.AddPostPublishedAndEditedDates do
  use Ecto.Migration

  def change do
    alter table(:blog_posts) do
      add :published_on, :date
      add :edited_on, :date
    end
  end
end
