class LinksController < ApplicationController

  def index
    redirect_to root_path if !current_user
  end

  def show
    @link = Link.find(params[:id])
  end

  def create
    @link = Link.new(link_params)
    @link.user_id = current_user.id if current_user
    if @link.save
      flash[:success] = "Link Created."
      redirect_to link_path(@link)
    else
      flash.now[:warning] = "Please enter a valid URL."
      render :index
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id)
  end
end
