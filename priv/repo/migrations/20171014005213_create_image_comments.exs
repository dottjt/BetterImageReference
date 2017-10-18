defmodule Bdr.Repo.Migrations.CreateImageComments do
  use Ecto.Migration

  def change do
    create table(:image_comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :text, :string
      
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :image_id, references(:images, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:image_comments, [:user_id])
    create index(:image_comments, [:image_id])
  end
end
