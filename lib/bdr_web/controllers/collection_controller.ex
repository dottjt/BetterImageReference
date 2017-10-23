defmodule BdrWeb.CollectionController do
  require Logger 

  use BdrWeb, :controller

  alias BdrWeb.AdminView
  
  alias Bdr.ApiResources
  alias Bdr.ApiResources.Collection

  action_fallback BdrWeb.FallbackController

  # API

  def index(conn, _params) do
    collections = ApiResources.list_collections_with_times_drawn()
    render(conn, "index.json", collections: collections)
  end

  def create(conn, %{"collection" => collection_params}) do
    with {:ok, %Collection{} = collection} <- ApiResources.create_collection(collection_params) do
      conn
      # |> put_status(:created)
      # |> put_resp_header("location", collection_path(conn, :show, collection))
      # |> render("show.json", collection: collection)
      {blogs, collections, images, users} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users)                                             
    end
  end

  def show(conn, %{"id" => id}) do
    collection = ApiResources.get_collection!(id)
    render(conn, "show.json", collection: collection)
  end

  def update(conn, %{"id" => id, "collection" => collection_params}) do
    collection = ApiResources.get_collection!(id)

    with {:ok, %Collection{} = collection} <- ApiResources.update_collection(collection, collection_params) do
      # render(conn, "show.json", collection: collection)
      {blogs, collections, images, users} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users)                                             
    end
  end

  def delete(conn, %{"id" => id}) do
    collection = ApiResources.get_collection!(id)
    with {:ok, %Collection{}} <- ApiResources.delete_collection(collection) do

      {blogs, collections, images, users} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users)                                 
    end
  end


  # CUSTOM API


  def indexWithTimesDrawn(conn, _params) do
    collections = ApiResources.list_collections_with_times_drawn()

    render(conn, "index.json", collections: collections)
  end


    # recieves a list of collections with which to retrieve images from. 
  def collectionWithImages(conn, %{"collections" => collections}) do
    Logger.info collections
    # %Collection{}
    collections |> Repo.preload(:images)
    render(conn, "index.json", collections: collections)
    
    # how do I enum through a list and pass to query? 
    # ApiResources.list_selected_collections_assoc()
  
  end

    # recieves a string, with which to fetch and return images. 
  def collectionSearchQuery(conn, %{"search_input" => search_input}) do
    # case search_input do
    #   "" ->
    #     send_resp(conn, 200, "")        
    #   _ ->
        collections = ApiResources.query_search_collection_list(search_input)                   
        render(conn, "index.json", collections: collections)        
    # end 
  end


  # PAGES

  def indexPage(conn, _params) do
    collections = ApiResources.list_collections()
    render conn, "index.html", collections: collections
  end
  
  def showPage(conn, %{"name" => name}) do  
    collection = ApiResources.get_collection_name_assoc!(name)
    
    render conn, "show.html", collection: collection
  end  

end
