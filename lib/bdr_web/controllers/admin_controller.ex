defmodule BdrWeb.AdminController do
    require Logger 
    use BdrWeb, :controller

    alias Bdr.Account
    alias Bdr.Account.User
    alias Bdr.Account.Email

    alias Bdr.ApiResources 
    alias Bdr.ApiResources.Blog
    alias Bdr.ApiResources.Collection
    alias Bdr.ApiResources.Image


  # ADMIN

  def loginPageAdmin(conn, _params) do
    render conn, "loginAdmin.html"        
  end

  def panelPageAdmin(conn, _params) do
    {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()

    render(conn, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)
  end


 # BLOG ADMIN PAGES

  def newBlogAdmin(conn, _params) do
    blog = %Blog{}
    changeset = ApiResources.change_blog(%Blog{})
    
    render conn, "newBlogAdmin.html", blog: blog, changeset: changeset
  end

  def editBlogAdmin(conn, %{"id" => id}) do
    blog = ApiResources.get_blog_assoc!(id)
    changeset = ApiResources.change_blog_assoc(blog)
    IO.inspect blog

    render conn, "editBlogAdmin.html", blog: blog, changeset: changeset
  end


  # COLLECTION ADMIN PAGES

  def newCollectionAdmin(conn, _params) do
    collection = %Collection{}
    changeset = ApiResources.change_collection(%Collection{})
    
    render conn, "newCollectionAdmin.html", collection: collection, changeset: changeset
  end

  def editCollectionAdmin(conn, %{"id" => id}) do
    collection = ApiResources.get_collection_assoc!(id)     
    changeset = ApiResources.change_collection_assoc(collection)    

    render conn, "editCollectionAdmin.html", collection: collection, changeset: changeset
  end  


  # IMAGE ADMIN PAGES

  def newImageAdmin(conn, _params) do
    image = %Image{}
    changeset = ApiResources.change_image(%Image{})
    
    render conn, "newImageAdmin.html", image: image, changeset: changeset
  end

  def editImageAdmin(conn, %{"id" => id}) do
    image = ApiResources.get_image_assoc!(id)
    changeset = ApiResources.change_image_assoc(image)    
    IO.inspect image.photo

    render conn, "editImageAdmin.html", image: image, changeset: changeset
  end  


# USER ADMIN PAGES

  def newUserAdmin(conn, _params) do
    user = %User{}
    changeset = Account.change_user(%User{})
    
    render conn, "newUserAdmin.html", user: user, changeset: changeset
  end  

  def editUserAdmin(conn, %{"id" => id}) do
    user = Account.get_user_assoc!(id)   
    changeset = Account.change_user_assoc(user)
    # IO.inspect user.avatar.file_name

    render conn, "editUserAdmin.html", user: user, changeset: changeset
  end
end
