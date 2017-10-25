defmodule Bdr.ApiResources.Collection do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Bdr.ApiResources.{Collection, Image}
  # alias Bdr.ApiResources.Image  
  alias Bdr.Collection.{Book, Tag, Category, Tutorial}
  # alias Bdr.Collection.Tag
  # alias Bdr.Collection.Category  
  # alias Bdr.Collection.Tutorial
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
    # belongs_to :category, Category

    has_many :collection_books, Book, on_delete: :delete_all 
    has_many :collection_tutorials, Tutorial, on_delete: :delete_all
    has_many :collection_tags, Tag, on_delete: :delete_all
    has_many :images, Image, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(%Collection{} = collection, attrs) do
    collection
    |> cast(attrs, [:name, :display_name, :featured_image, :external_url])
    |> validate_required([:name, :display_name, :featured_image])
  end

  def changeset_assoc(%Collection{} = collection, attrs) do
    collection
    |> cast(attrs, [:name, :display_name, :featured_image, :external_url])
    |> cast_assoc(:collection_books)
    |> validate_required([:name, :display_name, :featured_image])
  end
  
end
