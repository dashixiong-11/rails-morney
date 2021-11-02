class TaggingsController < ApplicationController
  before_action :must_sign_in # 请求前执行 (私有方法除外)

  def index
    render_resources Tagging.page(params[:page])
  end

  def show
    render_resource Tagging.find_by_id params[:id]
  end

  def create
    render_resource Tagging.create create_params.merge user: current_user
  end

  def destroy
    tagging = Tagging.find_by_id params[:id]
    head tagging.destroy ? :ok : :bad_request
  end

  private

  def create_params
    params.permit(:record_id, :tag_id)
  end
end
