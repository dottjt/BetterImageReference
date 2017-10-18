defmodule BdrWeb.EmailController do
  use BdrWeb, :controller

  alias Bdr.Account
  alias Bdr.Account.Email

  action_fallback BdrWeb.FallbackController

  def index(conn, _params) do
    emails = Account.list_emails()
    render(conn, "index.json", emails: emails)
  end

  def create(conn, %{"email" => email_params}) do
    with {:ok, %Email{} = email} <- Account.create_email(email_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", email_path(conn, :show, email))
      |> render("show.json", email: email)
    end
  end

  def show(conn, %{"id" => id}) do
    email = Account.get_email!(id)
    render(conn, "show.json", email: email)
  end

  def update(conn, %{"id" => id, "email" => email_params}) do
    email = Account.get_email!(id)

    with {:ok, %Email{} = email} <- Account.update_email(email, email_params) do
      render(conn, "show.json", email: email)
    end
  end

  def delete(conn, %{"id" => id}) do
    email = Account.get_email!(id)
    with {:ok, %Email{}} <- Account.delete_email(email) do
      send_resp(conn, :no_content, "")
    end
  end

  
  # EMAIL 
  def contactPage(conn, _params) do
    changeset = Email.changeset(%Email{})
    
    render conn, "contact.html", changeset: changeset   
  end  

  # ADMIN
  def indexPageAdmin(conn, _params) do
    emails = Account.list_emails()
    render conn, "indexAdmin.html", emails: emails
  end

  def showPageAdmin(conn, %{"name" => name}) do
    email = Account.get_email_name!(name)  

    render conn, "showAdmin.html", email: email
  end  
end
