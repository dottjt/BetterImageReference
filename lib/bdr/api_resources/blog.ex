defmodule Bdr.ApiResources.Blog do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Account.User  
  alias Bdr.ApiResources.Blog
  alias Bdr.Blog.Comment
  
  
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "blogs" do
    field :name, :string
    field :display_name, :string
    field :excerpt, :string
    field :featured_image, :string
    
    belongs_to :user, User
    has_many :comments, Comment, on_delete: :nothing 

    timestamps()
  end

  @doc false
  def changeset(%Blog{} = blog, attrs) do
    blog
    |> cast(attrs, [:name, :display_name, :featured_image, :excerpt])
    |> validate_required([:name, :display_name, :featured_image, :excerpt])
  end
end
