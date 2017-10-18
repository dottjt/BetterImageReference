defmodule Bdr.Repo.Migrations.CreateCollectionBooks do
  use Ecto.Migration

  def change do
    create table(:collection_books, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :url, :string
      add :collection_id, references(:collections, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:collection_books, [:collection_id])
  end
end
