class UsersController < ApplicationController
  def show
    @name = User.find(params[:id])
  end
end
