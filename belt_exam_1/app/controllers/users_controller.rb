class UsersController < ApplicationController
    # NOTES: If u wanna display the info in template, use @ sign. Otherwise, doesnt matter
    
    skip_before_action :require_login, only: [:new, :create]
    # means to skip he "before action" which was set to the require_login method in the 
    # application controller

    def new
    render 'new'
    end

    def show
    @user = User.find(params[:id])
    render 'show'
    end

    def create
    @user = User.create(user_params)
        if @user.valid?
            session[:user_id] = @user.id
            return redirect_to songs_path
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to :back
            # returns to previous route
        end
    end

    def edit
        @user = User.find(session[:user_id])
        render 'edit'
    end

    def update
    @user = User.find(session[:user_id])
    @user.update(update_params)
        if @user.valid?
            redirect_to user_path session[:user_id]
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to :back
        end
    end
    
    def destroy
    @user = User.find(session[:user_id])
        if @user
            @user.destroy
            redirect_to new_user_path
            reset_session
            # resets the session id
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to :back
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, 
        :password_confirmation)
    end

    def update_params
        params.require(:user).permit(:first_name, :last_name, :email)
    end

end
