defmodule BdrWeb.CollectionView do
  use BdrWeb, :view
  alias BdrWeb.CollectionView

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
end
