defmodule BdrWeb.UserController do
  use BdrWeb, :controller
  plug Ueberauth
  
  alias Bdr.Account
  alias Bdr.Account.User
  alias Bdr.ApiResources
  
  plug Guardian.Plug.EnsureAuthenticated, handler: BdrWeb.AuthController
  


  action_fallback BdrWeb.FallbackController

  # API
  
  def index(conn, _params) do
    users = Account.list_users()
    render(conn, "index.json", users: users)
  end

  def current(conn, _) do
    user = conn
    |> Guardian.Plug.current_resource

    conn
    |> render(BdrWeb.UserView, "show.json-api", data: user)
  end



  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      # conn
      # |> put_status(:created)
      # |> put_resp_header("location", user_path(conn, :show, user))
      # |> render("show.json", user: user)
      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)                                       
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      # render(conn, "show.json", user: user)
      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)                                       
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    with {:ok, %User{}} <- Account.delete_user(user) do
      # send_resp(conn, :no_content, "")
      {blogs, collections, images, users, emails} = ApiResources.list_admin_panel_resources()
      render(conn, AdminView, "panelAdmin.html", blogs: blogs, collections: collections, images: images, users: users, emails: emails)                                       
    end
  end

  # PAGES 

  def loginPage(conn, _params) do
    render conn, "login.html"        
  end  

  def signupPage(conn, _params) do
    render conn, "signup.html"        
  end  

  def forgotPage(conn, _params) do
    render conn, "forgot.html"        
  end  

end
