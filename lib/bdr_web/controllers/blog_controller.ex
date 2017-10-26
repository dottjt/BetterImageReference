defmodule BdrWeb.BlogController do
  use BdrWeb, :controller

  alias Bdr.ApiResources
  alias Bdr.ApiResources.Blog

  alias BdrWeb.AdminView

  action_fallback BdrWeb.FallbackController


  # API

  def index(conn, _params) do
    blogs = ApiResources.list_blogs()
    render(conn, "index.json", blogs: blogs)
  end

  def create(conn, %{"blog" => blog_params}) do

    {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
    
      case ApiResources.create_blog(blog_params) do
        {:ok, image} ->
          conn
          |> put_flash(:info, "Blog post was added!")
          |> render(AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)
        {:error, changeset} ->
          blog = %Blog{}
          conn
          |> put_flash(:error, "Something went wrong")
          |> render(AdminView, "newBlogAdmin.html", changeset: changeset, blog: blog)
      end
      # with {:ok, %Blog{} = blog} <- ApiResources.create_blog(blog_params) do
      # end
  end

  def show(conn, %{"id" => id}) do
    blog = ApiResources.get_blog!(id)
    render(conn, "show.json", blog: blog)
  end

  def update(conn, %{"id" => id, "blog" => blog_params}) do
    blog = ApiResources.get_blog!(id)

    with {:ok, %Blog{} = blog} <- ApiResources.update_blog(blog, blog_params) do
      # render(conn, "show.json", blog: blog)
      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)      
    end
  end

  
  def delete(conn, %{"id" => id}) do
    blog = ApiResources.get_blog!(id)
    with {:ok, %Blog{}} <- ApiResources.delete_blog(blog) do
      # send_resp(conn, :no_content, "")
      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)                                       
    end
  end


  # PAGES
  
  def indexPage(conn, _params) do
    blogs = ApiResources.list_blogs()    
    render conn, "index.html", blogs: blogs
  end

  def showPage(conn, %{"name" => name}) do
    blog = ApiResources.get_blog_name!(name)    
    render conn, "show.html", blog: blog   
  end  

end
