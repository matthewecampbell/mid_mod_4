class UserNotifier < ActionMailer::Base
  default from: "A-Link-From-Matt@matturlbox.herokuapp.com"

  def send_link_email(email, url)
    @url  = url
    mail(to: email,
       body: @url,
       content_type: "text/html",
       subject: "Someone wanted to send you a URL")
  end
end
