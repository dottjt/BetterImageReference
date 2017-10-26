defmodule Bdr.ApiResources.Image do
  
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  alias Bdr.ApiResources.Image
  alias Bdr.ApiResources.Collection
  alias Bdr.Image.Comment
  alias Bdr.Image.Scribble
  alias Bdr.Image.Tag
  alias Bdr.Image.Drawing
  
  alias Bdr.Photo.Type

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "images" do
    field :name, :string
    field :display_name, :string
    field :description, :string
    field :image_url, :string
    field :times_drawn, :integer
    # field :collection_id, :binary_id
    
    field :photo, Type
    
    has_many :image_comments, Comment
    has_many :image_scribbles, Scribble
    has_many :image_tags, Tag
    has_many :image_drawings, Drawing
    belongs_to :collection, Collection

    timestamps()
  end

  @doc false
  def changeset(%Image{} = image, attrs) do
    image    
    |> cast(attrs, [:name, :display_name, :description, :image_url, :times_drawn])
    |> cast_attachments(attrs, [:photo])
    |> validate_required([:name, :display_name, :description, :image_url, :times_drawn, :photo])
  end

  def changeset_assoc(%Image{} = image, attrs) do
    image
    |> cast(attrs, [:name, :display_name, :image_url, :description, :times_drawn])
    |> cast_attachments(attrs, [:photo])        
    # |> cast_assoc(:image_comments)
    |> validate_required([:name, :display_name, :description, :image_url, :times_drawn, :photo])
  end
  
end
