class LikesController < ApplicationController
      # before_action: login is here from app controller
  def create
    @like = Like.new(song_id: params[:id], user_id: session[:user_id])
    if @like.valid?
      @like.save
    else
      flash[:errors] = @like.errors.full_messages
    end
    redirect_to :back
  end

  def destroy
    @like = Like.where(song_id: params[:id], user_id: session[:user_id])
    @like.first.destroy
    redirect_to :back
  end
end
