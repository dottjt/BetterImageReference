defmodule BdrWeb.BlogView do
  use BdrWeb, :view
  alias BdrWeb.BlogView

  def render("index.json", %{blogs: blogs}) do
    %{data: render_many(blogs, BlogView, "blog.json")}
  end

  def render("show.json", %{blog: blog}) do
    %{data: render_one(blog, BlogView, "blog.json")}
  end

  def render("blog.json", %{blog: blog}) do
    %{id: blog.id,
      name: blog.name,
      display_name: blog.display_name,
      featured_image: blog.featured_image,
      excerpt: blog.excerpt}
  end
end
