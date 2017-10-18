defmodule Bdr.Account.Email do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bdr.Account.Email


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "emails" do
    field :name, :string
    field :recipient, :string
    field :subject, :string
    field :content, :string
    
    timestamps()
  end

  @doc false
  def changeset(%Email{} = email, attrs \\ %{}) do
    email
    |> cast(attrs, [:recipient, :subject, :name, :content])
    |> validate_required([:recipient, :subject, :name, :content])
  end
end
