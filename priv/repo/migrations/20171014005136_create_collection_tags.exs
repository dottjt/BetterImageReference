defmodule Bdr.Repo.Migrations.CreateCollectionTags do
  use Ecto.Migration

  def change do
    create table(:collection_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :collection_id, references(:collections, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:collection_tags, [:collection_id])
  end
end
