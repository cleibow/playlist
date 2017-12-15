class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]
    
    def new
        render 'sessions/new'
    end
    
    def create
        @user = User.find_by(email: params[:email])
        p @user
        if @user 
            if @user.try(:authenticate, params[:password])
            session[:user_id] = @user.id
            redirect_to songs_path
            else
            flash[:errors] = ["Password is incorrect"]
            redirect_to :back
            # strings must be in an array to display
            end
        else
            flash[:errors] = ["Email is incorrect"]
            redirect_to :back
        end
    
    end
    
    def destroy
        reset_session
        redirect_to main_path
        # Log User out
        # set session[:user_id] to null
        # redirect to login page
    end
    end

