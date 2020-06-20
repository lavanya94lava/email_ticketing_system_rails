# Preview all emails at http://localhost:3000/rails/mailers/reply_mailer
class ReplyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reply_mailer/new_reply
  def new_reply
    reply = {
        text: "hiii",
        sender: "singhlavanya94@gmail.com"
    }
    ReplyMailer.new_reply(reply)
  end

end
