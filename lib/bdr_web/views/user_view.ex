defmodule BdrWeb.UserView do
  use BdrWeb, :view
  alias BdrWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name,
      display_name: user.display_name,
      email: user.email,
      password: user.password,
      tier: user.tier}
  end
end
