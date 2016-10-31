class LinksController < ApplicationController

  def index
    redirect_to root_path if !current_user
  end


  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id if current_user
    if @link.save
      flash[:success] = "Link Created."
    else
      flash.now[:warning] = "Please enter a valid URL."
    end
    redirect_to links_path
  end

  def read
    @link = Link.find(params[:link_id])
    @link.read = true
    @link.save
  end

  def unread
    @link = Link.find(params[:link_id])
    @link.read = false
    @link.save
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(url: params[:url], title: params[:title])
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id)
  end
end
