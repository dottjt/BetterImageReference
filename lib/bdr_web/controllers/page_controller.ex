defmodule BdrWeb.PageController do
  use BdrWeb, :controller
  plug Ueberauth
  
  alias Bdr.Account  
  alias Bdr.Account.User
  alias Bdr.Account.Email
  
  alias Bdr.ApiResources.Collection  
  alias Bdr.ApiResources.Image  
  alias Bdr.ApiResources.Blog

  # GENERIC 
  def indexPage(conn, _params) do
    render conn, "index.html"
  end

  def aboutPage(conn, _params) do
    changeset = Account.change_email(%Email{})
    render conn, "about.html", changeset: changeset   
  end

  # APP
  def drawingToolPage(conn, _params) do
    render conn, "drawingTool.html"    
  end

end
