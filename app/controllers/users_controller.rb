class UsersController < ApplicationController

    def new 
    end

    def create 

        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to '/'
        else 
            redirect_to '/signup'
        end
    end

    def routing 


        @email = Email.find_by(mail_id: params[:email_id]);

        puts "eamilllllll"
        puts @email.sender

    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

end

