defmodule Bdr.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :display_name, :string
      add :avatar, :string 
      add :email, :string
      add :password, :string
      add :password_hash, :string 
      add :tier, :string
      add :auth_provider, :string
      add :is_admin, :boolean

      timestamps()
    end
    create index(:users, [:email], unique: true)
    
  end
end
