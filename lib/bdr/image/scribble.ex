defmodule Bdr.Image.Scribble do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bdr.Account.User
  alias Bdr.Image.Scribble
  alias Bdr.ApiResources.Image


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "image_scribbles" do
    field :name, :string    
    field :display_name, :string
    field :description, :string 
    field :data, :string    
    # field :image_id, :binary_id

    belongs_to :image, Image
    belongs_to :user, User
    
    
    timestamps()
  end

  @doc false
  def changeset(%Scribble{} = scribble, attrs) do
    scribble
    |> cast(attrs, [:name, :display_name, :description, :data])
    |> validate_required([:name, :display_name, :description, :data])
  end
end
