class Api::CategoryController < ApplicationController
  def index
    @categories = Category.search_children(params[:parent_id])
    respond_to do |format|
      format.json
    end
  end
end