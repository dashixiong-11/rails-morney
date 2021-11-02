class TagsController < ApplicationController
  before_action :must_sign_in

  def index
    render_resources Tag.page(params[:page])
  end

  def show
    render_resource Tag.find_by_id params[:id]
  end

  def create
    render_resource Tag.create create_params.merge user: current_user
  end

  def destroy
    tag = Tag.find_by_id params[:id]
    head tag.destroy ? :ok : :bad_request
  end

  def update
    tag = Tag.find_by_id params[:id]
    tag.update create_params
    render_resource tag
  end

  private #在此以下的方法都是私有的

  def create_params
    params.permit(:name)
  end
end
