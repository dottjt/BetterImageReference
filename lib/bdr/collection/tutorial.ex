defmodule Bdr.Collection.Tutorial do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Collection.Tutorial
  alias Bdr.ApiResources.Collection
  

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collection_tutorials" do
    field :display_name, :string
    field :name, :string
    field :url, :string
    # field :collection_id, :binary_id
    
    belongs_to :collection, Collection
    
    timestamps()
  end

  @doc false
  def changeset(%Tutorial{} = tutorial, attrs) do
    tutorial
    |> cast(attrs, [:name, :display_name, :url])
    |> validate_required([:name, :display_name, :url])
  end
end
