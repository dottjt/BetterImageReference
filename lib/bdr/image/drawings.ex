defmodule Bdr.Image.Drawing do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Image
  alias Bdr.User
  alias Bdr.Image.Drawing
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "image_drawings" do
    field :description, :string
    field :display_name, :string
    field :image_url, :string
    field :name, :string
    # field :image_id, :binary_id
    # field :user_id, :binary_id

    belongs_to :image, Image
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Drawing{} = drawings, attrs) do
    drawings
    |> cast(attrs, [:name, :display_name, :description, :image_url])
    |> validate_required([:name, :display_name, :description, :image_url])
  end
end
