defmodule BdrWeb.CollectionController do
  require Logger 

  use BdrWeb, :controller

  alias Bdr.ApiResources
  alias Bdr.ApiResources.Collection

  action_fallback BdrWeb.FallbackController


  # API

  def index(conn, _params) do
    collections = ApiResources.list_collections()
    render(conn, "index.json", collections: collections)
  end

  def create(conn, %{"collection" => collection_params}) do
    with {:ok, %Collection{} = collection} <- ApiResources.create_collection(collection_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", collection_path(conn, :show, collection))
      |> render("show.json", collection: collection)
    end
  end

  def show(conn, %{"id" => id}) do
    collection = ApiResources.get_collection!(id)
    render(conn, "show.json", collection: collection)
  end

  def update(conn, %{"id" => id, "collection" => collection_params}) do
    collection = ApiResources.get_collection!(id)

    with {:ok, %Collection{} = collection} <- ApiResources.update_collection(collection, collection_params) do
      render(conn, "show.json", collection: collection)
    end
  end

  def delete(conn, %{"id" => id}) do
    collection = ApiResources.get_collection!(id)
    with {:ok, %Collection{}} <- ApiResources.delete_collection(collection) do
      send_resp(conn, :no_content, "")
    end
  end




  # CUSTOM API

    # recieves a list of collections with which to retrieve images from. 
  def collectionWithImages(conn, %{"collection" => collection_params}) do
      
        # Enum.map(fn {k, v} -> )  
        #   |> ApiResources.get_collection_name_image_assoc()  
  end

    # recieves a string, with which to fetch and return images. 
  def collectionSearchQuery(conn, %{"search_input" => search_input}) do
    Logger.info search_input

    collections = ApiResources.list_collections()
                    # |> Enum.map(fn {_, v} -> v.name end)
                    # |> Enum.filter(fn {_, v} -> v =~ search_input end)
                  
    render(conn, "index.json", collections: collections)
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
