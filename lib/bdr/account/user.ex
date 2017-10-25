defmodule Bdr.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Bdr.Account.User
  alias Bdr.ApiResources    
  alias Bdr.Blog
  alias Bdr.Image
  

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :display_name, :string
    field :avatar, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :is_admin, :boolean, default: false
    field :tier, :string
    field :auth_provider, :string

    has_many :collections, ApiResources.Collection
    has_many :blog_comments, Blog.Comment
    has_many :image_comments, Image.Comment
    has_many :image_scribbles, Image.Scribble
    has_many :blog, ApiResources.Blog
    
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :display_name, :email, :password, :tier])
    |> validate_required([:name, :display_name, :email, :password, :tier])
  end

  def changeset_auth(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:email, :auth_provider, :name, :avatar])
    |> validate_required([:email, :auth_provider, :name, :avatar])
    |> unique_constraint(:email)
  end

  def changeset_assoc(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :display_name, :email, :password, :tier])
    |> cast_assoc([:image_comments, :blog_comments, :collections, :blog, :image_scribbles])
    |> validate_required([:name, :display_name, :email, :password, :tier])
  end

end
