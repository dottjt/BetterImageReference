defmodule Bdr.ApiResources do
  @moduledoc """
  The ApiResources context.
  """
  require Logger

  import Ecto.Query, warn: false
  alias Bdr.Repo
  alias Bdr.ApiResources.Blog
  alias Bdr.Account


  @doc """
  Returns everything needed for the panel.

  ## Examples

      iex> list_admin_panel_resources()

  """


  def list_admin_panel_resources do
    {list_blogs(), list_collections(), list_images(), Account.list_users(), Account.list_emails()}
  end




  @doc """
  Returns the list of blogs.

  ## Examples

      iex> list_blogs()
      [%Blog{}, ...]

  """

  def list_blogs do
    Repo.all(Blog)
  end

  def list_blogs_assoc do
    Repo.all(Blog) |> Repo.preload(:blog_comments)
  end


  @doc """
  Gets a single blog.

  Raises `Ecto.NoResultsError` if the Blog does not exist.

  ## Examples

      iex> get_blog!(123)
      %Blog{}

      iex> get_blog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blog!(id), do: Repo.get!(Blog, id)
  def get_blog_assoc!(id), do: Repo.get!(Blog, id) |> Repo.preload(:blog_comments)

  def get_blog_name!(name), do: Repo.get_by!(Blog, name: name)
  
  def get_blog_name_assoc!(name), do: Repo.get_by!(Blog, name: name) |> Repo.preload(:blog_comments)
  

  @doc """
  Creates a blog.

  ## Examples

      iex> create_blog(%{field: value})
      {:ok, %Blog{}}

      iex> create_blog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blog(attrs \\ %{}) do
    %Blog{}
    |> Blog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blog.

  ## Examples

      iex> update_blog(blog, %{field: new_value})
      {:ok, %Blog{}}

      iex> update_blog(blog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blog(%Blog{} = blog, attrs) do
    blog
    |> Blog.changeset_assoc(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Blog.

  ## Examples

      iex> delete_blog(blog)
      {:ok, %Blog{}}

      iex> delete_blog(blog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blog(%Blog{} = blog) do
    Repo.delete(blog)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blog changes.

  ## Examples

      iex> change_blog(blog)
      %Ecto.Changeset{source: %Blog{}}

  """
  def change_blog(%Blog{} = blog) do
    Blog.changeset(blog, %{})
  end

  def change_blog_assoc(%Blog{} = blog) do
    Blog.changeset_assoc(blog, %{})
  end



  alias Bdr.ApiResources.Collection

  @doc """
  Returns the list of collections.

  ## Examples

      iex> list_collections()
      [%Collection{}, ...]

  """
  def list_collections do
    Repo.all(Collection)  
  end
  
  def list_collections_assoc do
    Repo.all(Collection) |> Repo.preload([:images, :collection_books, :collection_tutorials, :collection_tags])
  end

  # for homepage 
  def list_collections_with_times_drawn do
    Repo.all(Collection) |> Repo.preload(:images)
    # Repo.all(Collection) |> Repo.preload(images: [:times_drawn])
  end

  def query_search_collection_list(search_input) do
    Repo.all(from c in Collection,
             where: ilike(c.display_name, ^"%#{search_input}%") and ilike(c.name, ^"%#{search_input}%"),
            #  preload: [images: i],
             select: c)
  end
  

  @doc """
  Gets a single collection.

  Raises `Ecto.NoResultsError` if the Collection does not exist.

  ## Examples

      iex> get_collection!(123)
      %Collection{}

      iex> get_collection!(456)
      ** (Ecto.NoResultsError)

  """
  def get_collection!(id), do: Repo.get!(Collection, id)
  def get_collection_assoc!(id), do: Repo.get!(Collection, id) |> Repo.preload([:images, :collection_books, :collection_tutorials, :collection_tags])
  def get_collection_name!(name), do: Repo.get_by!(Collection, name: name)

  def get_collection_name_assoc!(name), do: Repo.get_by!(Collection, name: name) |> Repo.preload([:images, :collection_books, :collection_tutorials, :collection_tags])         
  
  def get_collection_name_assoc_images!(name), do: Repo.get_by!(Collection, name: name) |> Repo.preload([:images])         


  @doc """
  Creates a collection.

  ## Examples

      iex> create_collection(%{field: value})
      {:ok, %Collection{}}

      iex> create_collection(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_collection(attrs \\ %{}) do
    %Collection{}
    |> Collection.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a collection.

  ## Examples

      iex> update_collection(collection, %{field: new_value})
      {:ok, %Collection{}}

      iex> update_collection(collection, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_collection(%Collection{} = collection, attrs) do
    collection
    |> Collection.changeset_assoc(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Collection.

  ## Examples

      iex> delete_collection(collection)
      {:ok, %Collection{}}

      iex> delete_collection(collection)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection(%Collection{} = collection) do
    Repo.delete(collection)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection changes.

  ## Examples

      iex> change_collection(collection)
      %Ecto.Changeset{source: %Collection{}}

  """
  def change_collection(%Collection{} = collection) do
    Collection.changeset(collection, %{})
  end

  def change_collection_assoc(%Collection{} = collection) do
    Collection.changeset_assoc(collection, %{})
  end

  alias Bdr.ApiResources.Image

  @doc """
  Returns the list of images.

  ## Examples

      iex> list_images()
      [%Image{}, ...]

  """
  def list_images do
    Repo.all(Image)
  end

  def list_images_assoc do
    Repo.all(Image) |> Repo.preload([:image_comments, :image_scribbles, :image_tags])
  end




  #images join with collection details, user details.  
  def list_images_load_app(collections) do 

    # collection_id_list = Enum.map(collections, fn(x) -> x.id end)

    query = from i in Image,
            join: c in Collection,
            # where: i.collection_id > c.id
            # preload: c

    query = from [i, c] in query,
            select: {i, c}
            
    Repo.all(query)
            
  end


  @doc """
  Gets a single image.

  Raises `Ecto.NoResultsError` if the Image does not exist.

  ## Examples

      iex> get_image!(123)
      %Image{}

      iex> get_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image!(id), do: Repo.get!(Image, id)
  def get_image_assoc!(id), do: Repo.get!(Image, id) |> Repo.preload([:image_comments, :image_scribbles, :image_tags])  
  def get_image_name!(name), do: Repo.get_by!(Image, name: name)
  def get_image_name_assoc!(name), do: Repo.get_by!(Image, name: name) |> Repo.preload([:image_comments, :image_scribbles, :image_tags]) 
  
  

  @doc """
  Creates a image.

  ## Examples

      iex> create_image(%{field: value})
      {:ok, %Image{}}

      iex> create_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a image.

  ## Examples

      iex> update_image(image, %{field: new_value})
      {:ok, %Image{}}

      iex> update_image(image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset_assoc(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Image.

  ## Examples

      iex> delete_image(image)
      {:ok, %Image{}}

      iex> delete_image(image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image changes.

  ## Examples

      iex> change_image(image)
      %Ecto.Changeset{source: %Image{}}

  """
  def change_image(%Image{} = image) do
    Image.changeset(image, %{})
  end
  def change_image_assoc(%Image{} = image) do
    Image.changeset_assoc(image, %{})
  end
  
end
