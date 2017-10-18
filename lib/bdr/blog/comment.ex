defmodule Bdr.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Blog.Comment
  alias Bdr.ApiResources.Blog
  alias Bdr.Account.User
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "blog_comments" do
    field :text, :string
    # field :blog_id, :binary_id
    # field :user_id, :binary_id

    belongs_to :blog, Blog
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
