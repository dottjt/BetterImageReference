defmodule Bdr.Repo.Migrations.CreateImageTags do
  use Ecto.Migration

  def change do
    create table(:image_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :image_id, references(:images, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:image_tags, [:image_id])
  end
end
