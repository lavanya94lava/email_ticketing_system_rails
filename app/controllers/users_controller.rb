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
        
        getUserId = params[:user][:user_id]
        @user = User.find(getUserId);

        @email = Email.find_by(mail_id: params[:email_id]);

        puts "params in routing"

        puts params


        puts "@user.name"
        puts @user.name

        puts "@email.sender"
        puts @email.sender

        
        @user.emails.push(@email)

        @user.save

        redirect_to "/users/#{getUserId}";
        
    end


    def show 
        @user = User.find(params[:id]);
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

end

