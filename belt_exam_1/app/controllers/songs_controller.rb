class SongsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create]

    def index
        @songs = Song.all
        @songs.sort_by &:created_at
        p "these are all the songs", @songs
        @user = current_user
        render 'index'
      end
    def show 
        @song = Song.find(params[:song_id])
        p @song
        users = @song.users
        users.each do |user|
            likes = user.likes.where(song_id: params[:song_id]).length
            p likes
            
        end 
        p "users", @song.users
        render 'playlist'
    end
    
      def create
        p song_params
        @song = Song.new(song_params)
        if @song.valid?
            p @song
            @song.save
            redirect_to :back
        else
            p "messed up"
            flash[:errors] = @song.errors.full_messages
            redirect_to :back
        end
      end
    
      def destroy
        @song = Song.find(params[:id])
        id = params[:user_id].to_i
        if session[:user_id] != id
          @song.errors.add("user did not create this song")
          redirect_to :back
        end
        if @song
          @song.destroy
          redirect_to user_path session[:user_id]
        else
          flash[:errors] = @song.errors.full_messages
          redirect_to :back
        end
      end
    
      private
      def song_params
        params.require(:song).permit(:title, :artist).merge(user_id: session[:user_id])
        # merge adds the key user_id into the params hash
      end
    
      def auth
        id = params[:user_id].to_i
        # .to_i converts object into integer
        return redirect_to user_path params[:user_id] unless session[:user_id] == id
      end
end
