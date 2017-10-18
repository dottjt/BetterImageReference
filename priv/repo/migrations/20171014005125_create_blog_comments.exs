defmodule Bdr.Repo.Migrations.CreateBlogComments do
  use Ecto.Migration

  def change do
    create table(:blog_comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string
      
      add :blog_id, references(:blogs, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:blog_comments, [:blog_id])
    create index(:blog_comments, [:user_id])
  end
end
