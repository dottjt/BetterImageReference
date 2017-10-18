defmodule BdrWeb.BlogControllerTest do
  use BdrWeb.ConnCase

  alias Bdr.ApiResources
  alias Bdr.ApiResources.Blog

  @create_attrs %{display_name: "some display_name", excerpt: "some excerpt", featured_image: "some featured_image", name: "some name"}
  @update_attrs %{display_name: "some updated display_name", excerpt: "some updated excerpt", featured_image: "some updated featured_image", name: "some updated name"}
  @invalid_attrs %{display_name: nil, excerpt: nil, featured_image: nil, name: nil}

  def fixture(:blog) do
    {:ok, blog} = ApiResources.create_blog(@create_attrs)
    blog
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all blogs", %{conn: conn} do
      conn = get conn, blog_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create blog" do
    test "renders blog when data is valid", %{conn: conn} do
      conn = post conn, blog_path(conn, :create), blog: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, blog_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "display_name" => "some display_name",
        "excerpt" => "some excerpt",
        "featured_image" => "some featured_image",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, blog_path(conn, :create), blog: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update blog" do
    setup [:create_blog]

    test "renders blog when data is valid", %{conn: conn, blog: %Blog{id: id} = blog} do
      conn = put conn, blog_path(conn, :update, blog), blog: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, blog_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "display_name" => "some updated display_name",
        "excerpt" => "some updated excerpt",
        "featured_image" => "some updated featured_image",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, blog: blog} do
      conn = put conn, blog_path(conn, :update, blog), blog: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete blog" do
    setup [:create_blog]

    test "deletes chosen blog", %{conn: conn, blog: blog} do
      conn = delete conn, blog_path(conn, :delete, blog)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, blog_path(conn, :show, blog)
      end
    end
  end

  defp create_blog(_) do
    blog = fixture(:blog)
    {:ok, blog: blog}
  end
end
