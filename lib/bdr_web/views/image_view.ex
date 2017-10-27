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
      description: image.description,
      times_drawn: image.times_drawn,
      photo: image.photo,
      image_url: image.image_url}
  end

  # ASSOC

  def render("index_with_all_assoc.json", %{images: images}) do
    %{data: render_many(images, ImageView, "image_with_all_assoc.json")}
  end

  def render("image_with_all_assoc.json", %{image: image}) do
    %{id: image.id,
      # user_id: image.user_id,  
      image_url: image.image_url,  
      name: image.name,
      display_name: image.display_name,
      description: image.description,
      times_drawn: image.times_drawn,
      photo: image.photo,
      image_comments: render_many(image.image_comments, ImageView, "image_comments.json"),
      image_scribbles: render_many(image.image_scribbles, ImageView, "image_scribbles.json"),
      image_drawings: render_many(image.image_drawings, ImageView, "image_drawings.json"),
      image_tags: render_many(image.image_tags, ImageView, "image_tags.json")}
  end




  def render("image_comments.json", %{image: image}) do
    %{id: image.id,
      text: image.text}
      # user_id: image.user_id}
  end

  def render("image_scribbles.json", %{image: image}) do
    %{id: image.id,
      name: image.name,
      display_name: image.display_name,
      description: image.description,      
      data: image.data}
      # user_id: image.user_id}
  end

  def render("image_drawings.json", %{image: image}) do
    %{id: image.id,
      name: image.name,    
      display_name: image.display_name,
      description: image.description,      
      image_url: image.image_url}
      # user_id: image.user_id}
  end

  def render("image_tags.json", %{image: image}) do
    %{id: image.id,
      name: image.name,
      display_name: image.display_name}
      # user_id: image.user_id}
  end

end
