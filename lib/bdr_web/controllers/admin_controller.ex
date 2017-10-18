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
    blog = ApiResources.list_blogs()   
    collection = ApiResources.list_collections()
    image = ApiResources.list_images()    
    user = Account.list_users()    
    
    render conn, "panelAdmin.html", blog: blog, collection: collection, image: image, user: user                                  
  end  


 # BLOG ADMIN PAGES

  def newBlogAdmin(conn, _params) do
    changeset = ApiResources.change_blog(%Blog{})
    
    render conn, "newBlogAdmin.html", changeset: changeset
  end  

  def editBlogAdmin(conn, %{"id" => id}) do
    blog = Accounts.get_blog!(id)
    changeset = Accounts.change_blog(blog)

    render conn, "editBlogAdmin.html", blog: blog, changeset: changeset
  end


  # COLLECTION ADMIN PAGES

  def newCollectionAdmin(conn, _params) do
    changeset = ApiResources.change_collection(%Collection{})
    
    render conn, "newCollectionAdmin.html", changeset: changeset
  end

  def editCollectionAdmin(conn, %{"id" => id}) do
    collection = ApiResources.get_collection!(id)     
    changeset = ApiResources.change_collection(collection)    

    render conn, "editCollectionAdmin.html", collection: collection, changeset: changeset
  end  


  # IMAGE ADMIN PAGES

  def newImageAdmin(conn, _params) do
    changeset = ApiResources.change_image(%Image{})
    
    render conn, "newImageAdmin.html", changeset: changeset
  end

  def editImageAdmin(conn, %{"id" => id}) do
    image = ApiResources.get_image!(id)
    changeset = ApiResources.change_image(image)    
    
    render conn, "editImageAdmin.html", image: image, changeset: changeset
  end  


# USER ADMIN PAGES

  def newUserAdmin(conn, _params) do
    changeset = Account.change_user(%User{})

    render conn, "newUserAdmin.html", changeset: changeset
  end  

  def editUserAdmin(conn, %{"id" => id}) do
    user = Account.get_user!(id)   
    changeset = Account.change_user(user)
    
    render conn, "editUserAdmin.html", user: user 
  end
end


#   def indexBlogAdmin(conn, _params) do
#     render conn, "indexBlogAdmin.html", blog: blog
#   end

#   def indexCollectionAdmin(conn, _params) do
#     collections = ApiResources.list_collections()
#     render conn, "indexCollectionAdmin.html", collections: collections
#   end
#   def indexImageAdmin(conn, _params) do
#     render conn, "indexImageAdmin.html"
#   end
#   def indexUserAdmin(conn, _params) do
#     users = Account.list_users()    
#     render conn, "indexUserAdmin.html", users: users
#   end