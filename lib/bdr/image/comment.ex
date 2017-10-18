defmodule Bdr.Image.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Image.Comment
  alias Bdr.ApiResources.Image
  alias Bdr.Account.User
  

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "image_comments" do
    field :text, :string
    # field :user_id, :binary_id
    # field :image_id, :binary_id
    
    belongs_to :image, Image
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:name, :display_name, :text])
    |> validate_required([:name, :display_name, :text])
  end
end
