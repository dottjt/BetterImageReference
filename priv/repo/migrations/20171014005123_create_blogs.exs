defmodule Bdr.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :featured_image, :string
      add :excerpt, :string
      
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

  end
end
