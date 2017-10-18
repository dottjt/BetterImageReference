defmodule Bdr.Image.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Image.Tag
  alias Bdr.ApiResources.Image
  

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "image_tags" do
    field :display_name, :string
    field :name, :string
    # field :image_id, :binary_id
    belongs_to :image, Image
    
    timestamps()
  end

  @doc false
  def changeset(%Tag{} = tag, attrs) do
    tag
    |> cast(attrs, [:name, :display_name])
    |> validate_required([:name, :display_name])
  end
end
