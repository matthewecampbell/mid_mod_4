class UserNotifier < ActionMailer::Base
  default from: "do-not-reply@matturlbox.herokuapp.com"

  def send_link_email(email, url)
    @url  = url
    mail(to: email, subject: "Someone wanted to send you a URL!")
  end
end
