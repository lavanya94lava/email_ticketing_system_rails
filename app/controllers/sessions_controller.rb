class SessionsController < ApplicationController
    def create

        puts "User id"
        puts params 
        user = User.find_by_email(params[:user][:email])
        # If the user exists AND the password entered is correct.
        if user && user.authenticate(params[:user][:password])
          # Save the user id inside the browser cookie. This is how we keep the user 
          # logged in when they navigate around our website.
          session[:user_id] = user.id

          if current_user.admin
            redirect_to '/'
          else 
            redirect_to "/users/#{user.id}"
          end
        else
        # If user's login doesn't work, send them back to the login form.
          redirect_to '/login'
        end
      end
    
      def destroy
        session[:user_id] = nil
        redirect_to '/login'
      end
end
