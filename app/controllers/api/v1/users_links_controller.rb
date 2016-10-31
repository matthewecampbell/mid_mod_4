class Api::V1::UsersLinksController < ApplicationController
  def index
    @links = current_user.links
  end
end
