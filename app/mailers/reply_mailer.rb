class ReplyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reply_mailer.new_reply.subject
  #

  # here we are sending email
  def new_reply(reply)
    @reply = reply
  
    mail to: @reply["sender"],
         subject: @reply["subject"],
         thread_id: @reply["thread_id"]
  end
end
