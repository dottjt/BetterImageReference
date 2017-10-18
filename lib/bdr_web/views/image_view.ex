defmodule BdrWeb.ImageView do
  use BdrWeb, :view
  alias BdrWeb.ImageView

  def render("index.json", %{images: images}) do
    %{data: render_many(images, ImageView, "image.json")}
  end

  def render("show.json", %{image: image}) do
    %{data: render_one(image, ImageView, "image.json")}
  end

  def render("image.json", %{image: image}) do
    %{id: image.id,
      name: image.name,
      display_name: image.display_name,
      image_url: image.image_url}
  end
end
