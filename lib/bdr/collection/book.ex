defmodule Bdr.Collection.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Collection.Book
  alias Bdr.ApiResources.Collection
  

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collection_books" do
    field :display_name, :string
    field :name, :string
    field :url, :string
    # field :collection_id, :binary_id
    belongs_to :collection, Collection
    
    timestamps()
  end

  @doc false
  def changeset(%Book{} = book, attrs) do
    book
    |> cast(attrs, [:name, :display_name, :url])
    |> validate_required([:name, :display_name, :url])
  end
end
