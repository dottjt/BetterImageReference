defmodule BdrWeb.CollectionController do
  require Logger 

  use BdrWeb, :controller

  alias BdrWeb.AdminView
  alias BdrWeb.ImageView

  alias Bdr.ApiResources
  alias Bdr.ApiResources.Collection

  action_fallback BdrWeb.FallbackController

  # API

  def index(conn, _params) do
    collections = ApiResources.list_collections()
    render(conn, "index.json", collections: collections)
  end

  def create(conn, %{"collection" => collection_params}) do

    {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
    
    case ApiResources.create_collection(collection_params) do
      {:ok, collection} ->
        conn
        |> put_flash(:info, "Collection was added!")
        |> render(AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)
      {:error, changeset} ->
        collection = %Collection{}
        conn
        |> put_flash(:error, "Something went wrong")
        |> render(AdminView, "newCollectionAdmin.html", changeset: changeset, collection: collection)
    end
        
    # with {:ok, %Collection{} = collection} <- ApiResources.create_collection(collection_params) do
    # end
  end

  def show(conn, %{"id" => id}) do
    collection = ApiResources.get_collection!(id)
    render(conn, "show.json", collection: collection)
  end

  def update(conn, %{"id" => id, "collection" => collection_params}) do
    collection = ApiResources.get_collection!(id)

    with {:ok, %Collection{} = collection} <- ApiResources.update_collection(collection, collection_params) do
      # render(conn, "show.json", collection: collection)
      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)                                             
    end
  end

  def delete(conn, %{"id" => id}) do
    collection = ApiResources.get_collection!(id)
    with {:ok, %Collection{}} <- ApiResources.delete_collection(collection) do

      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)                                 
    end
  end


  # CUSTOM API


  def initialLoadSearch(conn, _params) do 
    collections = ApiResources.list_collections_initial_load_search()
    render(conn, "index.json", collections: collections)
  end

  def initialLoadApp(conn, %{"_json" => _json}) do # initial application start
  IO.inspect _json
  images = ApiResources.list_images_load_app(_json)
    render(conn, ImageView, "index_with_all_assoc.json", images: images)  
  end

  def collectionSearchQuery(conn, %{"search_input" => search_input}) do # query search string
    collections = ApiResources.query_search_collection_list(search_input)                   
    render(conn, "index.json", collections: collections)        
  end




  # PAGES

  def indexPage(conn, _params) do
    collections = ApiResources.list_collections()
    render conn, "indexPage.html", collections: collections
  end
  
  def showPage(conn, %{"name" => name}) do  
    collection = ApiResources.get_collection_name_assoc!(name)
    
    render conn, "showPage.html", collection: collection
  end  

end
