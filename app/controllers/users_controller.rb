#this file pertains to the users of the app, we can create, route them to their specific pages, update them ,delete them
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

    # this is used to add the emails to specific users and then take them to their own page
    def routing 
        
        getUserId = params[:user][:user_id]
        @user = User.find(getUserId);

        @email = Email.find_by(mail_id: params[:email_id]);

        
        @user.emails.push(@email)

        @user.save

        redirect_to "/users/#{getUserId}";
        
    end


    #this shows the working page of the user
    def show 
        @user = User.find(params[:id]);
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

end

