defmodule BdrWeb.Router do
  use BdrWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BdrWeb do
    pipe_through :browser 

    get "/", PageController, :indexPage
    get "/about", PageController, :aboutPage
    get "/timed-drawing-practice", PageController, :drawingToolPage

    get "/collections", CollectionController, :indexPage
    get "/collections/:name", CollectionController, :showPage  

    get "/collections/:name/view_all", ImageController, :indexPage 

    get "/blog", BlogController, :indexPage
    get "/blog/:name", BlogController, :showPage  

    get "/login", UserController, :loginPage
    get "/signup", UserController, :signupPage
    get "/forgot", UserController, :forgotPage     

    get "/contact", EmailController, :contactPage       


    scope "/admin" do
      get "/", AdminController, :loginPageAdmin
      get "/panel", AdminController, :panelPageAdmin 
      
      get "/collections/new", AdminController, :newCollectionAdmin
      get "/collections/:id", AdminController, :editCollectionAdmin
  
      get "/images/new", AdminController, :newImageAdmin
      get "/images/:id", AdminController, :editImageAdmin
  
      get "/users/new", AdminController, :newUserAdmin
      get "/users/:id", AdminController, :editUserAdmin
  
      get "/blogs/new", AdminController, :newBlogAdmin
      get "/blogs/:id", AdminController, :editBlogAdmin  
    end
  end

  scope "/api", BdrWeb do
    pipe_through :api

    resources "/blog", BlogController, only: [:index, :show]
    resources "/collections", CollectionController, except: [:new, :edit]
         post "/collections/with_images", CollectionController, :collectionWithImages
         post "/collections/collection_search_query", CollectionController, :collectionSearchQuery
    
    resources "/images", ImageController, except: [:new, :edit]
  end

end

