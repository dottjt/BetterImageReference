defmodule Bdr.Collection.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Collection.Category


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collection_categories" do
    field :display_name, :string
    field :name, :string
    field :collection_id, :binary_id

    has_many :collections, Tag, on_delete: :delete_all    
    
    timestamps()
  end

  @doc false
  def changeset(%Category{} = category, attrs) do
    category
    |> cast(attrs, [:name, :display_name])
    |> validate_required([:name, :display_name])
  end
end
