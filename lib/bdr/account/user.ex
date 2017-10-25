defmodule Bdr.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Bdr.Account.User
  alias Bdr.{Blog, Image, ApiResources} # comment
  # alias Bdr.ApiResources # collection, blog  
  # alias Bdr.Image # comment, scribble
  

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
    |> cast(attrs, [:name, :display_name, :email, :password, :tier, :is_admin, :auth_provider])
    |> validate_required([:name, :display_name, :email, :password, :tier, :is_admin, :auth_provider])
  end

  # def changeset_auth(%User{} = user, attrs) do
  #   user
  #   |> cast(attrs, [:email, :auth_provider, :name, :avatar])
  #   |> validate_required([:email, :auth_provider, :name, :avatar])
  #   |> unique_constraint(:email)
  # end

  # def signup(struct, params \\ %{}) do
  #   struct
  #     |> cast(params, [:email, :password, :password_confirmation])
  #     |> validate_required([email, :password, :password_confirmation])
  #     |> validate_format(:email, ~r/@/)
  #     |> validate_length(:password, min: 5)
  #     |> password_and_confirmation_matches()
  #     |> generate_password_hash()
  # end

  # # ...

  # defp generate_password_hash(changeset) do
  #   password = get_change(changeset, :password)
  #   hash = Comeonin.Bcrypt.hashpwsalt(password)
  #   changeset |> put_change(:password_hash, hash)
  # end


  # def registration_changeset(model, params) do
  #   model
  #   |> changeset(params)                  # do other standard validations
  #   |> cast(params, [:password])          # include :password in the changeset
  #   |> validate_length(:password, min: 8) # validations
  #   |> put_pass_hash()                    # transform into :password_digest
  # end
  
  def changeset_assoc(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :display_name, :email, :password, :tier])
    |> cast_assoc([:image_comments, :blog_comments, :collections, :blog, :image_scribbles])
    |> validate_required([:name, :display_name, :email, :password, :tier])
  end

end
