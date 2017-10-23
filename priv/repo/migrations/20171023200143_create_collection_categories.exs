defmodule Bdr.Repo.Migrations.CreateCollectionCategories do
  use Ecto.Migration

  def change do
    create table(:collection_categories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :collection_id, references(:collections, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:collection_categories, [:collection_id])
  end
end
