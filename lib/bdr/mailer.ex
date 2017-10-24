defmodule Bdr.Mailer do
    use Mailgun.Client,
        domain: Application.get_env(:bdr, :mailgun_domain),
        key: Application.get_env(:bdr, :mailgun_key)

    def my_first_email(email_address) do
      send_email to: email_address,
      from: "test@example.com",
      subject: "My first email",
      text: "This is an email send with Phoenix and Mailgun"
    end

    def send_email(recipient, subject, content) do
      send_email to: recipient,
      from: "your@email.com",
      subject: subject,
      text: content
    #  html: content // allows us to send html emails 
    #  We simply added a ‘html’ to our function. Our mailer will send both a text and a HTML email to our recipient.
    end      
  end
  