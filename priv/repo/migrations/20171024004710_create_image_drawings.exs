defmodule Bdr.Repo.Migrations.CreateImageDrawings do
  use Ecto.Migration

  def change do
    create table(:image_drawings, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :description, :string
      add :image_url, :string

      add :image_id, references(:images, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps()
    end
    
    create index(:image_drawings, [:user_id])    
    create index(:image_drawings, [:image_id])
  end
end
