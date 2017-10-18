defmodule BdrWeb.EmailControllerTest do
  use BdrWeb.ConnCase

  alias Bdr.Account
  alias Bdr.Account.Email

  @create_attrs %{content: "some content", name: "some name", recipient: "some recipient", subject: "some subject"}
  @update_attrs %{content: "some updated content", name: "some updated name", recipient: "some updated recipient", subject: "some updated subject"}
  @invalid_attrs %{content: nil, name: nil, recipient: nil, subject: nil}

  def fixture(:email) do
    {:ok, email} = Account.create_email(@create_attrs)
    email
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all emails", %{conn: conn} do
      conn = get conn, email_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create email" do
    test "renders email when data is valid", %{conn: conn} do
      conn = post conn, email_path(conn, :create), email: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, email_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "content" => "some content",
        "name" => "some name",
        "recipient" => "some recipient",
        "subject" => "some subject"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, email_path(conn, :create), email: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update email" do
    setup [:create_email]

    test "renders email when data is valid", %{conn: conn, email: %Email{id: id} = email} do
      conn = put conn, email_path(conn, :update, email), email: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, email_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "content" => "some updated content",
        "name" => "some updated name",
        "recipient" => "some updated recipient",
        "subject" => "some updated subject"}
    end

    test "renders errors when data is invalid", %{conn: conn, email: email} do
      conn = put conn, email_path(conn, :update, email), email: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete email" do
    setup [:create_email]

    test "deletes chosen email", %{conn: conn, email: email} do
      conn = delete conn, email_path(conn, :delete, email)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, email_path(conn, :show, email)
      end
    end
  end

  defp create_email(_) do
    email = fixture(:email)
    {:ok, email: email}
  end
end
