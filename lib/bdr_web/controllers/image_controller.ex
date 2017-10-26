defmodule BdrWeb.ImageController do
  use BdrWeb, :controller

  require Logger 

  alias Bdr.ApiResources
  alias Bdr.ApiResources.Image
  alias BdrWeb.AdminView

  action_fallback BdrWeb.FallbackController

  def index(conn, _params) do
    images = ApiResources.list_images()
    render(conn, "index.json", images: images)
  end

  def create(conn, %{"image" => image_params}) do

    case ApiResources.create_image(image_params) do
      {:ok, image} ->
        {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()        
        
        conn
        |> put_flash(:info, "Image was added!")
        |> render(AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)
      {:error, changeset} ->
        {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()                
        image = %Image{}
        
        conn
        |> put_flash(:error, "Something went wrong")
        |> render(AdminView, "newImageAdmin.html", changeset: changeset, image: image)
    end
  
    # with {:ok, %Image{} = image} <- ApiResources.create_image(image_params) do
    #   {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
    #   render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)    
    # end
  end

  def show(conn, %{"id" => id}) do
    image = ApiResources.get_image!(id)
    render(conn, "show.json", image: image)
  end

  def update(conn, %{"id" => id, "image" => image_params}) do
    image = ApiResources.get_image!(id)

    with {:ok, %Image{} = image} <- ApiResources.update_image(image, image_params) do
      # render(conn, "show.json", image: image)
      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)      
    end
  end

  def delete(conn, %{"id" => id}) do
    image = ApiResources.get_image!(id)
    with {:ok, %Image{}} <- ApiResources.delete_image(image) do
      # send_resp(conn, :no_content, "")
      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)                                       
    end
  end


  # PAGE 

  def indexPage(conn, %{"name" => name}) do
    collection = ApiResources.get_collection_name_assoc_images!(name)
        
    IO.inspect collection 
    render conn, "indexPage.html", collection: collection
  end
end
