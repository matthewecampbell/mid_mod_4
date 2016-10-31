class Api::V1::UsersLinksController < ApplicationController

  def show
    @links = User.find(params[:id]).links
  end

end
