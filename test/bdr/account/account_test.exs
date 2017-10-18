defmodule Bdr.AccountTest do
  use Bdr.DataCase

  alias Bdr.Account

  describe "users" do
    alias Bdr.Account.User

    @valid_attrs %{display_name: "some display_name", email: "some email", name: "some name", password: "some password", tier: "some tier"}
    @update_attrs %{display_name: "some updated display_name", email: "some updated email", name: "some updated name", password: "some updated password", tier: "some updated tier"}
    @invalid_attrs %{display_name: nil, email: nil, name: nil, password: nil, tier: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.display_name == "some display_name"
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password == "some password"
      assert user.tier == "some tier"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Account.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.display_name == "some updated display_name"
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
      assert user.tier == "some updated tier"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end

  describe "emails" do
    alias Bdr.Account.Email

    @valid_attrs %{content: "some content", name: "some name", recipient: "some recipient", subject: "some subject"}
    @update_attrs %{content: "some updated content", name: "some updated name", recipient: "some updated recipient", subject: "some updated subject"}
    @invalid_attrs %{content: nil, name: nil, recipient: nil, subject: nil}

    def email_fixture(attrs \\ %{}) do
      {:ok, email} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_email()

      email
    end

    test "list_emails/0 returns all emails" do
      email = email_fixture()
      assert Account.list_emails() == [email]
    end

    test "get_email!/1 returns the email with given id" do
      email = email_fixture()
      assert Account.get_email!(email.id) == email
    end

    test "create_email/1 with valid data creates a email" do
      assert {:ok, %Email{} = email} = Account.create_email(@valid_attrs)
      assert email.content == "some content"
      assert email.name == "some name"
      assert email.recipient == "some recipient"
      assert email.subject == "some subject"
    end

    test "create_email/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_email(@invalid_attrs)
    end

    test "update_email/2 with valid data updates the email" do
      email = email_fixture()
      assert {:ok, email} = Account.update_email(email, @update_attrs)
      assert %Email{} = email
      assert email.content == "some updated content"
      assert email.name == "some updated name"
      assert email.recipient == "some updated recipient"
      assert email.subject == "some updated subject"
    end

    test "update_email/2 with invalid data returns error changeset" do
      email = email_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_email(email, @invalid_attrs)
      assert email == Account.get_email!(email.id)
    end

    test "delete_email/1 deletes the email" do
      email = email_fixture()
      assert {:ok, %Email{}} = Account.delete_email(email)
      assert_raise Ecto.NoResultsError, fn -> Account.get_email!(email.id) end
    end

    test "change_email/1 returns a email changeset" do
      email = email_fixture()
      assert %Ecto.Changeset{} = Account.change_email(email)
    end
  end
end
