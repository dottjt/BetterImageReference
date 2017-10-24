defmodule Bdr.Image.Drawings do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Image.Drawings


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "image_drawings" do
    field :description, :string
    field :display_name, :string
    field :image_url, :string
    field :name, :string
    field :image_id, :binary_id
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(%Drawings{} = drawings, attrs) do
    drawings
    |> cast(attrs, [:name, :display_name, :description, :image_url])
    |> validate_required([:name, :display_name, :description, :image_url])
  end
end
