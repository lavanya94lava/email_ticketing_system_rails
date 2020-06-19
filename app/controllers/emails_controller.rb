class EmailsController < ApplicationController

    def show
        @email = Email.find(params[:id]);
    end


    def destroy
        @email = Email.find(params[:id]);
        @email.destroy;
        redirect_to email_path
    end
end
