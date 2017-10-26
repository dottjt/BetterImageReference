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
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.Deserializer
    plug :fetch_session
    plug :fetch_flash        # this has been added to it
  end

  pipeline :api_auth do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug JaSerializer.Deserializer
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

    scope "/admin" do      
      get "/", AdminController, :panelPageAdmin      
      get "/login", AdminController, :loginPageAdmin
      
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

  scope "/auth", BdrWeb do 
    pipe_through :api_auth

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback

    resources "/users", UserController, except: [:new, :edit]
      get "/user/current", UserController, :current, as: :current_user
      delete "/logout", AuthController, :delete
  end

  scope "/api", BdrWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]    
    resources "/blog", BlogController, except: [:new, :edit]
    resources "/email", EmailController, except: [:new, :edit]    
    resources "/collections", CollectionController, except: [:new, :edit]
         get  "/collections_initial_load_search", CollectionController, :initialLoadSearch
    
         post "/collections_initial_load_app", CollectionController, :initialLoadApp
         post "/collections/collection_search_query", CollectionController, :collectionSearchQuery
    
    resources "/images", ImageController, except: [:new, :edit]
  end

end

