class ReplyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reply_mailer.new_reply.subject
  #
  def new_reply(reply)
    @reply = reply
  
    mail to: @reply["sender"],
         subject: "Making my new app in Ruby on Rails"
  end
end
