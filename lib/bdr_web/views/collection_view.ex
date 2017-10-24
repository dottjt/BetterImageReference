defmodule BdrWeb.CollectionView do
  use BdrWeb, :view
  alias BdrWeb.CollectionView
  alias BdrWeb.ImageView

  def render("index.json", %{collections: collections}) do
    %{data: render_many(collections, CollectionView, "collection.json")}
  end

  def render("show.json", %{collection: collection}) do
    %{data: render_one(collection, CollectionView, "collection.json")}
  end

  def render("collection.json", %{collection: collection}) do
    %{id: collection.id,
      name: collection.name,
      display_name: collection.display_name,
      user_id: collection.user_id,
      featured_image: collection.featured_image,
      external_url: collection.external_url}
  end

  def render("loadedImage.json", %{image: image}) do
    %{id: image.id,
      name: image.name,
      display_name: image.display_name,
      image_url: image.image_url,
      # collection_name: image.featured_image
      # collection_display_name: image.user_id,
    }
  end

  def render("collection_app_load.json", %{images: images}) do
    %{ images: render_many(images, CollectionView, "loadedImage.json", as: :image)}
  end


  # def render("collection_app_load.json", %{collections: collections, images: images, users: users}) do
  #   %{collections: render_many(collections, CollectionView, "collection.json"),
  #     images: render_many(images, ImageView, "collection.json")}
  # end

  
end
