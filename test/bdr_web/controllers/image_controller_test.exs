defmodule BdrWeb.ImageControllerTest do
  use BdrWeb.ConnCase

  alias Bdr.ApiResources
  alias Bdr.ApiResources.Image

  @create_attrs %{display_name: "some display_name", image_url: "some image_url", name: "some name"}
  @update_attrs %{display_name: "some updated display_name", image_url: "some updated image_url", name: "some updated name"}
  @invalid_attrs %{display_name: nil, image_url: nil, name: nil}

  def fixture(:image) do
    {:ok, image} = ApiResources.create_image(@create_attrs)
    image
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all images", %{conn: conn} do
      conn = get conn, image_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create image" do
    test "renders image when data is valid", %{conn: conn} do
      conn = post conn, image_path(conn, :create), image: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, image_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "display_name" => "some display_name",
        "image_url" => "some image_url",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, image_path(conn, :create), image: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update image" do
    setup [:create_image]

    test "renders image when data is valid", %{conn: conn, image: %Image{id: id} = image} do
      conn = put conn, image_path(conn, :update, image), image: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, image_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "display_name" => "some updated display_name",
        "image_url" => "some updated image_url",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, image: image} do
      conn = put conn, image_path(conn, :update, image), image: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete image" do
    setup [:create_image]

    test "deletes chosen image", %{conn: conn, image: image} do
      conn = delete conn, image_path(conn, :delete, image)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, image_path(conn, :show, image)
      end
    end
  end

  defp create_image(_) do
    image = fixture(:image)
    {:ok, image: image}
  end
end
