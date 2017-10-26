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

  # def render("index_assoc_images.json", %{images: images}) do
  #   %{data: render_many(images, ImageView, "image_with_all_assoc.json")}
  # end

  # def render("collection_assoc_images.json", %{collection: collection}) do
  #   %{id: collection.id,
  #     name: collection.name,
  #     display_name: collection.display_name,
  #     user_id: collection.user_id,
  #     featured_image: collection.featured_image,
  #     external_url: collection.external_url,
  #     images: render_many(collection.images, ImageView, "image.json")}
  # end

end
