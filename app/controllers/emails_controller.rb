#this file contains the controller part of Emails, i.e all the manipulation regarding Emails happen here
class EmailsController < ApplicationController

    #reply to the email id or thread id from which the mail is coming from 
    def reply
        #extract the sender, subject, email body and thread id of the mail from the view file of show users
        sender = params[:email_sender];
        text = params[:user][:email];
        subject = params[:email_subject];
        thread_id = params[:id];

        #make a reply id object to send it through action mailer
        @reply = { 
            "text"  =>text,
            "sender" =>sender,
            "subject" => subject,
            "thread_id" => thread_id
        }

        @email = Email.find_by(mail_id: thread_id)

        #ReplyMailer inherits its properties from application mailer which in turn inherits them from action mailer
        ReplyMailer.new_reply(@reply).deliver_now

        #once the employee has replied to the query, update the status to true
        @email.isResolved = true;

        @email.save;

        #this is to show the response that the request was complete
        respond_to do |format|
            format.html {redirect_to "/users/#{current_user.id}"}
            format.json { render json: @reply}
        end
    end
end
