defmodule Bdr.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :description, :string 
      add :image_url, :string
      
      add :collection_id, references(:collections, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:images, [:collection_id])
    # this used to be create index(:images, [:image_id]), but it was an error and I'm not sure what the purpose of this is.
    
  end
end
