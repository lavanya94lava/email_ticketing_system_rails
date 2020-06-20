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


        puts "whyyyyyyyyyyyyyyyyyyyyyyyyyyy"
        puts params
        getUserId = params[:user][:user_id]

        @user = User.find(getUserId);


        puts "here is the thing you are looking for"
        
        @user.emails << (@email)

        puts @emails

        @user.save

        redirect_to "/users/#{getUserId}";
        
    end


    def show 
        @user = User.find(params[:id])

    end

    private
        def email_params
            params.require(:user).permit(:email_id, :email_subject, :email_sender, :email_body)
        end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

end

