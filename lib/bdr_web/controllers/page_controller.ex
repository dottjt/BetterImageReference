defmodule BdrWeb.PageController do
  use BdrWeb, :controller

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
    render conn, "about.html"    
  end

  # APP
  def drawingToolPage(conn, _params) do
    render conn, "drawingTool.html"    
  end

end
