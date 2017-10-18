defmodule Bdr.ApiResourcesTest do
  use Bdr.DataCase

  alias Bdr.ApiResources

  describe "blogs" do
    alias Bdr.ApiResources.Blog

    @valid_attrs %{display_name: "some display_name", excerpt: "some excerpt", featured_image: "some featured_image", name: "some name"}
    @update_attrs %{display_name: "some updated display_name", excerpt: "some updated excerpt", featured_image: "some updated featured_image", name: "some updated name"}
    @invalid_attrs %{display_name: nil, excerpt: nil, featured_image: nil, name: nil}

    def blog_fixture(attrs \\ %{}) do
      {:ok, blog} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ApiResources.create_blog()

      blog
    end

    test "list_blogs/0 returns all blogs" do
      blog = blog_fixture()
      assert ApiResources.list_blogs() == [blog]
    end

    test "get_blog!/1 returns the blog with given id" do
      blog = blog_fixture()
      assert ApiResources.get_blog!(blog.id) == blog
    end

    test "create_blog/1 with valid data creates a blog" do
      assert {:ok, %Blog{} = blog} = ApiResources.create_blog(@valid_attrs)
      assert blog.display_name == "some display_name"
      assert blog.excerpt == "some excerpt"
      assert blog.featured_image == "some featured_image"
      assert blog.name == "some name"
    end

    test "create_blog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApiResources.create_blog(@invalid_attrs)
    end

    test "update_blog/2 with valid data updates the blog" do
      blog = blog_fixture()
      assert {:ok, blog} = ApiResources.update_blog(blog, @update_attrs)
      assert %Blog{} = blog
      assert blog.display_name == "some updated display_name"
      assert blog.excerpt == "some updated excerpt"
      assert blog.featured_image == "some updated featured_image"
      assert blog.name == "some updated name"
    end

    test "update_blog/2 with invalid data returns error changeset" do
      blog = blog_fixture()
      assert {:error, %Ecto.Changeset{}} = ApiResources.update_blog(blog, @invalid_attrs)
      assert blog == ApiResources.get_blog!(blog.id)
    end

    test "delete_blog/1 deletes the blog" do
      blog = blog_fixture()
      assert {:ok, %Blog{}} = ApiResources.delete_blog(blog)
      assert_raise Ecto.NoResultsError, fn -> ApiResources.get_blog!(blog.id) end
    end

    test "change_blog/1 returns a blog changeset" do
      blog = blog_fixture()
      assert %Ecto.Changeset{} = ApiResources.change_blog(blog)
    end
  end

  describe "collections" do
    alias Bdr.ApiResources.Collection

    @valid_attrs %{display_name: "some display_name", external_url: "some external_url", featured_image: "some featured_image", name: "some name", user_id: "some user_id"}
    @update_attrs %{display_name: "some updated display_name", external_url: "some updated external_url", featured_image: "some updated featured_image", name: "some updated name", user_id: "some updated user_id"}
    @invalid_attrs %{display_name: nil, external_url: nil, featured_image: nil, name: nil, user_id: nil}

    def collection_fixture(attrs \\ %{}) do
      {:ok, collection} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ApiResources.create_collection()

      collection
    end

    test "list_collections/0 returns all collections" do
      collection = collection_fixture()
      assert ApiResources.list_collections() == [collection]
    end

    test "get_collection!/1 returns the collection with given id" do
      collection = collection_fixture()
      assert ApiResources.get_collection!(collection.id) == collection
    end

    test "create_collection/1 with valid data creates a collection" do
      assert {:ok, %Collection{} = collection} = ApiResources.create_collection(@valid_attrs)
      assert collection.display_name == "some display_name"
      assert collection.external_url == "some external_url"
      assert collection.featured_image == "some featured_image"
      assert collection.name == "some name"
      assert collection.user_id == "some user_id"
    end

    test "create_collection/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApiResources.create_collection(@invalid_attrs)
    end

    test "update_collection/2 with valid data updates the collection" do
      collection = collection_fixture()
      assert {:ok, collection} = ApiResources.update_collection(collection, @update_attrs)
      assert %Collection{} = collection
      assert collection.display_name == "some updated display_name"
      assert collection.external_url == "some updated external_url"
      assert collection.featured_image == "some updated featured_image"
      assert collection.name == "some updated name"
      assert collection.user_id == "some updated user_id"
    end

    test "update_collection/2 with invalid data returns error changeset" do
      collection = collection_fixture()
      assert {:error, %Ecto.Changeset{}} = ApiResources.update_collection(collection, @invalid_attrs)
      assert collection == ApiResources.get_collection!(collection.id)
    end

    test "delete_collection/1 deletes the collection" do
      collection = collection_fixture()
      assert {:ok, %Collection{}} = ApiResources.delete_collection(collection)
      assert_raise Ecto.NoResultsError, fn -> ApiResources.get_collection!(collection.id) end
    end

    test "change_collection/1 returns a collection changeset" do
      collection = collection_fixture()
      assert %Ecto.Changeset{} = ApiResources.change_collection(collection)
    end
  end

  describe "images" do
    alias Bdr.ApiResources.Image

    @valid_attrs %{display_name: "some display_name", image_url: "some image_url", name: "some name"}
    @update_attrs %{display_name: "some updated display_name", image_url: "some updated image_url", name: "some updated name"}
    @invalid_attrs %{display_name: nil, image_url: nil, name: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ApiResources.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert ApiResources.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert ApiResources.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = ApiResources.create_image(@valid_attrs)
      assert image.display_name == "some display_name"
      assert image.image_url == "some image_url"
      assert image.name == "some name"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApiResources.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, image} = ApiResources.update_image(image, @update_attrs)
      assert %Image{} = image
      assert image.display_name == "some updated display_name"
      assert image.image_url == "some updated image_url"
      assert image.name == "some updated name"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = ApiResources.update_image(image, @invalid_attrs)
      assert image == ApiResources.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = ApiResources.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> ApiResources.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = ApiResources.change_image(image)
    end
  end
end
