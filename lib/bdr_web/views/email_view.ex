defmodule BdrWeb.EmailView do
  use BdrWeb, :view
  alias BdrWeb.EmailView

  def render("index.json", %{emails: emails}) do
    %{data: render_many(emails, EmailView, "email.json")}
  end

  def render("show.json", %{email: email}) do
    %{data: render_one(email, EmailView, "email.json")}
  end

  def render("email.json", %{email: email}) do
    %{id: email.id,
      recipient: email.recipient,
      subject: email.subject,
      name: email.name,
      content: email.content}
  end
end
