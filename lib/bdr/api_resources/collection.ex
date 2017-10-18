defmodule Bdr.ApiResources.Collection do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.ApiResources.Collection
  alias Bdr.ApiResources.Image  
  alias Bdr.Collection.Book
  alias Bdr.Collection.Tag
  alias Bdr.Collection.Tutorial
  alias Bdr.Account.User
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "collections" do
    field :name, :string 
    field :display_name, :string
    field :external_url, :string
    field :featured_image, :string
    # field :user_id, :binary_id
    
    belongs_to :user, User
    
    has_many :collection_books, Book
    has_many :collection_tutorials, Tutorial
    has_many :collection_tags, Tag
    has_many :images, Image

    timestamps()
  end

  @doc false
  def changeset(%Collection{} = collection, attrs) do
    collection
    |> cast(attrs, [:name, :display_name, :user_id, :featured_image, :external_url])
    |> validate_required([:name, :display_name, :user_id, :featured_image, :external_url])
  end
end
