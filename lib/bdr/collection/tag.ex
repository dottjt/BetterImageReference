defmodule Bdr.Collection.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Collection.Tag
  alias Bdr.ApiResources.Collection
  

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collection_tags" do
    field :display_name, :string
    field :name, :string
    # field :collection_id, :binary_id
    
    belongs_to :collection, Collection
    
    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :display_name])
    |> validate_required([:name, :display_name])
  end
end
