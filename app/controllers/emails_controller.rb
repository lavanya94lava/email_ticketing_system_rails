class EmailsController < ApplicationController

    def show
        @email = Email.find(params[:id]);
    end

    def reply
        sender = params[:email_sender];
        text = params[:user][:email];

        @reply = { 
            "text"  =>text,
            "sender" =>sender   
        }

        ReplyMailer.new_reply(@reply).deliver_now

        respond_to do |format|
            format.html {redirect_to "/"}
            format.json { render json: @reply}
        end
    end

    def destroy
        @email = Email.find(params[:id]);
        @email.destroy;
        redirect_to email_path;
    end
end
