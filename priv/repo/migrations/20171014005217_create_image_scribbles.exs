defmodule Bdr.Repo.Migrations.CreateImageScribbles do
  use Ecto.Migration

  def change do
    create table(:image_scribbles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :description, :string
      add :data, :string

      add :image_id, references(:images, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      
      timestamps()
    end

    create index(:image_scribbles, [:image_id])
  end
end
