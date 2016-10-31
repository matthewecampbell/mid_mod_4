class LinksController < ApplicationController

  def index
    redirect_to root_path if !current_user
  end


  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id if current_user
    if @link.save
      flash[:success] = "Link Created."
      render :index
    else
      flash.now[:warning] = "Please enter a valid URL."
      render :index
    end
  end

  def read
    @link = Link.find(params[:link_id])
    @link.read = true
    @link.save
    render :index
  end

  def unread
    @link = Link.find(params[:link_id])
    @link.read = false
    @link.save
    render :index
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(url: params[:url], title: params[:title])
    render :index
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id)
  end
end
